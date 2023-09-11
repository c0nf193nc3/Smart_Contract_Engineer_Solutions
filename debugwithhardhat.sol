// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Import the Hardhat console library for debugging
import "hardhat/console.sol";

// Define a simple ERC20 token contract called Token
contract Token {
    // Declare a mapping to track token balances of addresses
    mapping(address => uint) public balances;

    // Constructor initializes the contract and assigns an initial balance
    constructor() {
        // Assign an initial balance of 100 tokens to the contract creator (msg.sender)
        balances[msg.sender] = 100;
    }

    // External function to transfer tokens from the sender to a specified recipient
    function transfer(address to, uint amount) external {
        // Deduct the transferred amount from the sender's balance
        balances[msg.sender] -= amount;

        // Add the transferred amount to the recipient's balance
        balances[to] += amount;

        // Log the transfer details for debugging purposes
        console.log("transfer", msg.sender, to, amount);
    }
}

/*
Here's a step-by-step explanation of the code:

1. The contract begins with SPDX license information and specifies the Solidity version.

2. It imports the `console` library from Hardhat, which allows for debugging and logging messages during contract execution.

3. The contract is named `Token` and represents a simple ERC20 token.

4. Inside the contract, there is a mapping named `balances` that associates Ethereum addresses with their token balances.

5. The constructor is called when the contract is deployed. It initializes the contract creator's (the deployer's) balance with 100 tokens.

6. The `transfer` function is defined as an external function. It allows users to transfer tokens from their account to another recipient.

7. Inside the `transfer` function:
   - It deducts the transferred `amount` from the sender's (`msg.sender`) balance.
   - It adds the transferred `amount` to the recipient's (`to`) balance.
   - It logs a message using `console.log` to display details about the transfer, including the sender, recipient, and amount. This is for debugging purposes.

This contract essentially serves as a basic ERC20 token with a fixed supply of 100 tokens. Users can transfer tokens to each other, and these transactions will be logged for debugging purposes using the `console` library.
*/