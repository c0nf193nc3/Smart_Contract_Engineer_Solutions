// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ReentrancyGuard {
    // Count stores the number of times the function test was called
    uint public count;
    bool private locked;

    // Modifier to prevent reentrancy by locking the execution
    modifier lock() {
        // Ensure that the contract is not already locked
        require(!locked, "locked");
        // Lock the contract to prevent reentrancy during the function execution
        locked = true;
        _; // Continue with the function execution
        // Unlock the contract after the function execution is complete
        locked = false;
    }

    // Function test is intended to demonstrate reentrancy protection
    function test(address _contract) external lock {
        // Make a low-level call to the specified contract address with an empty data payload
        (bool success, ) = _contract.call("");
        // Check if the call was successful, and if not, revert the transaction
        require(success, "tx failed");
        // Increment the count to keep track of the number of times the function is called
        count += 1;
    }
}