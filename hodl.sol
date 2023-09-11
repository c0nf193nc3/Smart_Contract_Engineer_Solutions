// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Hodl {
    // Define a constant to set the HODL duration to 3 years (3 * 365 days)
    uint private constant HODL_DURATION = 3 * 365 days;

    // Mapping to store the balance of each user
    mapping(address => uint) public balanceOf;

    // Mapping to store the timestamp until which the funds are locked for each user
    mapping(address => uint) public lockedUntil;

    // Function to allow users to deposit funds into the contract
    function deposit() external payable {
        // Increase the balance of the sender with the sent Ether
        balanceOf[msg.sender] += msg.value;

        // Set the timestamp until which the funds are locked for the sender
        lockedUntil[msg.sender] = block.timestamp + HODL_DURATION; 
    }

    // Function to allow users to withdraw their funds after the lock period expires
    function withdraw() external {
        // Check if the lock period has expired for the sender
        require(block.timestamp > lockedUntil[msg.sender], "not unlocked");

        // Get the balance of the sender
        uint bal = balanceOf[msg.sender];

        // Delete the sender's balance to prevent reentrant calls
        delete balanceOf[msg.sender];

        // Transfer the balance back to the sender
        payable(msg.sender).transfer(bal);
    }
}

/*
Explanation:

- The `Hodl` contract allows users to deposit funds and lock them for a specified duration.

- It defines a constant `HODL_DURATION` to set the lock period to 3 years (3 * 365 days).

- The contract uses two mappings:
  - `balanceOf`: This mapping stores the balance of Ether for each user.
  - `lockedUntil`: This mapping stores the timestamp until which the funds are locked for each user.

- The `deposit` function allows users to deposit Ether into the contract. It increases the balance of the sender and sets the `lockedUntil` timestamp to the current timestamp plus the specified lock duration.

- The `withdraw` function allows users to withdraw their funds, but only after the lock period has expired. It checks if the current timestamp is greater than the `lockedUntil` timestamp for the sender, indicating that the funds are unlocked. If the lock period has expired, it transfers the user's balance back to them and deletes their balance to prevent reentrant calls.

This contract is a simple example of a time-locked savings contract, where users can deposit funds and lock them for a specific duration before being able to withdraw them.
*/
