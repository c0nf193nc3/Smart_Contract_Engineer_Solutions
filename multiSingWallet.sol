// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MultiSigWallet {
    // Events to log various actions within the contract.
    event Deposit(address indexed sender, uint amount);
    event Submit(uint indexed txId);
    event Approve(address indexed owner, uint indexed txId);
    event Revoke(address indexed owner, uint indexed txId);
    event Execute(uint indexed txId);

    // Struct to represent a transaction.
    struct Transaction {
        address to;      // Target address for the transaction.
        uint value;      // Amount of Ether to send with the transaction.
        bytes data;      // Transaction data (e.g., function call encoded data).
        bool executed;   // Flag indicating whether the transaction has been executed.
    }

    // Array to store the addresses of owners.
    address[] public owners;
    
    // Mapping to check if an address is an owner.
    mapping(address => bool) public isOwner;
    
    // Number of required approvals for a transaction.
    uint public required;

    // Array to store transactions.
    Transaction[] public transactions;
    
    // Mapping to track approved transactions by transaction ID and owner.
    mapping(uint => mapping(address => bool)) public approved;

    // Modifier to restrict access to owners only.
    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    // Modifier to check if a transaction with a given ID exists.
    modifier txExists(uint _txId) {
        require(_txId < transactions.length, "tx does not exist");
        _;
    }

    // Modifier to check if a transaction has not been approved by the sender.
    modifier notApproved(uint _txId) {
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    // Modifier to check if a transaction has not been executed.
    modifier notExecuted(uint _txId) {
        require(!transactions[_txId].executed, "tx already executed");
        _;
    }

    // Fallback function to accept Ether deposits and log them.
    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    // Constructor to initialize the contract with a list of owners and the required number of approvals.
    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0, "owners required");
        require(
            _required > 0 && _required <= _owners.length,
            "invalid required number of owners"
        );

        for (uint i; i < _owners.length; i++) {
            address owner = _owners[i];

            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner is not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }

        required = _required;
    }
    
    // Function to submit a new transaction.
    function submit(address _to, uint _value, bytes calldata _data) external onlyOwner {
        transactions.push(Transaction(_to, _value, _data, false));
        emit Submit(transactions.length - 1);
    }
    
    // Function for an owner to approve a transaction.
    function approve(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) notApproved(_txId) {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }
    
    // Function to execute a transaction once it's approved by the required number of owners.
    function execute(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        uint approveCount;
        for (uint i = 0; i < owners.length; i++) {
            if (approved[_txId][owners[i]]) {
                approveCount += 1;
            }
        }
        require(approveCount >= required, "not approved");
        Transaction storage t = transactions[_txId];
        transactions[_txId].executed = true;
        (bool success, ) = t.to.call{value: t.value}(t.data);
        require(success, "tx failed");
        emit Execute(_txId);
    }
    
    // Function for an owner to revoke approval for a transaction.
    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId) {
        require(approved[_txId][msg.sender], "not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId);
    }
}