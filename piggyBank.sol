// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract PiggyBank {
    // Event to log deposit actions.
    event Deposit(uint amount);
    // Event to log withdrawal actions.
    event Withdraw(uint amount);

    // Address of the contract owner.
    address public owner;
    
    // Constructor sets the contract deployer as the owner.
    constructor() {
        owner = msg.sender;
    }
    
    // The receive function is a special function that allows the contract to accept Ether transfers.
    receive() external payable {
        // When Ether is received, emit a Deposit event to log the amount received.
        emit Deposit(msg.value);
    }
    
    // Function to withdraw funds from the contract (only accessible by the owner).
    function withdraw() external {
        // Ensure that the caller is the owner; otherwise, raise an error.
        require(msg.sender == owner, "not owner");
        
        // Emit a Withdraw event to log the amount being withdrawn.
        emit Withdraw(address(this).balance);
        
        // Use selfdestruct to send the contract's balance to the owner's address.
        selfdestruct(payable(owner));
    }
}