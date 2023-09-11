// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract TimeLock {
    event Queue(
        bytes32 indexed txId,
        address indexed target,
        uint value,
        string func,
        bytes data,
        uint timestamp
    );
    event Execute(
        bytes32 indexed txId,
        address indexed target,
        uint value,
        string func,
        bytes data,
        uint timestamp
    );
    event Cancel(bytes32 indexed txId);

    // Constants defining time limits and grace period
    uint public constant MIN_DELAY = 10; // seconds
    uint public constant MAX_DELAY = 1000; // seconds
    uint public constant GRACE_PERIOD = 1000; // seconds

    address public owner; // Address of the contract owner
    // Mapping to track queued transactions by their unique transaction ID
    mapping(bytes32 => bool) public queued;

    constructor() {
        owner = msg.sender; // Set the contract owner to the deployer's address
    }

    receive() external payable {}

    // Function to calculate a unique transaction ID based on input parameters
    function getTxId(
        address _target,
        uint _value,
        string calldata _func,
        bytes calldata _data,
        uint _timestamp
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(_target, _value, _func, _data, _timestamp));
    }

    /**
     * @param _target Address of contract or account to call
     * @param _value Amount of ETH to send
     * @param _func Function signature, for example "foo(address,uint256)"
     * @param _data ABI encoded data to send.
     * @param _timestamp Timestamp after which the transaction can be executed.
     */
    function queue(
        address _target,
        uint _value,
        string calldata _func,
        bytes calldata _data,
        uint _timestamp
    ) external returns (bytes32 txId) {
        require(msg.sender == owner, "owner only");
        require(block.timestamp + MIN_DELAY < _timestamp &&
            block.timestamp + MAX_DELAY > _timestamp, "invalid delay time");
        bytes32 txId = getTxId(_target, _value, _func, _data, _timestamp);
        require(!queued[txId], "queued"); // Ensure the transaction is not already queued
        queued[txId] = true; // Mark the transaction as queued
        emit Queue(txId, _target, _value, _func, _data, _timestamp);
    }

    function execute(
        address _target,
        uint _value,
        string calldata _func,
        bytes calldata _data,
        uint _timestamp
    ) external payable returns (bytes memory) {
        require(msg.sender == owner, "owner only");
        require(block.timestamp > _timestamp &&
            block.timestamp - GRACE_PERIOD < _timestamp, "invalid delay time");
        bytes32 txId = getTxId(_target, _value, _func, _data, _timestamp);
        require(queued[txId], "not queued"); // Ensure the transaction is queued
        delete queued[txId]; // Remove the transaction from the queue

        bytes memory data;
        if (bytes(_func).length > 0) {
            // If a function signature is provided, encode it with the data
            data = abi.encodePacked(bytes4(keccak256(bytes(_func))), _data);
        } else {
            // If no function signature is provided, call the contract's fallback function with the data
            data = _data;
        }

        (bool success, bytes memory result) = _target.call{value: _value}(data);
        require(success, "call failed"); // Ensure the call to the target contract was successful
        emit Execute(txId, _target, _value, _func, _data, _timestamp); // Emit an "Execute" event
        return result; // Return the result of the executed transaction
    }

    // Function to cancel a queued transaction
    function cancel(bytes32 _txId) external {
        require(msg.sender == owner, "owner only");
        require(queued[_txId], "not queued"); // Ensure the transaction is queued
        delete queued[_txId]; // Remove the transaction from the queue
        emit Cancel(_txId); // Emit a "Cancel" event
    }
}

/*
Here's the explanation of the code:

1. The "TimeLock" contract allows for the scheduling and execution of transactions with a time delay.

2. It defines three events: "Queue," "Execute," and "Cancel," to log various contract actions.

3. Constants `MIN_DELAY`, `MAX_DELAY`, and `GRACE_PERIOD` are used to define time limits and a grace period for transactions.

4. The contract has an "owner" variable, initialized to the deployer's address.

5. The "receive" function allows the contract to receive Ether.

6. The "getTxId" function calculates a unique transaction ID based on input parameters, which is used to identify queued transactions.

7. The "queue" function allows the owner to schedule a transaction to be executed in the future. It performs the following:
   - Validates that the caller is the owner.
   - Checks the timestamp for the delay to ensure it falls within the specified range.
   - Generates a unique transaction ID using "getTxId."
   - Ensures that the transaction is not already queued.
   - Marks the transaction as queued and emits a "Queue" event.

8. The "execute" function allows the owner to execute a queued transaction once the specified delay has passed. It performs the following:
   - Validates that the caller is the owner.
   - Checks the timestamp to ensure it has passed and is within the grace period.
   - Validates that the transaction is queued.
   - Deletes the transaction from the queue.
   - Encodes the function call data, including the function signature and parameters.
   - Calls the target contract with the specified value and data.
   - Emits an "Execute" event and returns the result of the executed transaction.

9. The "cancel" function allows the owner to cancel a queued transaction. It performs the following:
   - Validates that the caller is the owner.
   - Validates that the transaction is queued.
   - Deletes the transaction from the queue.
   - Emits a "Cancel" event.

This contract enables the owner to schedule and execute transactions with a time delay, providing a useful mechanism for time-sensitive operations while allowing for cancellation if necessary.
*/