// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Import the "Account" contract, assuming it's defined in a separate file "Account.sol".
import "./Account.sol";

contract Bank {
    // Declare a dynamic array of Account contracts.
    Account[] public accounts;

    // Function to create a new Account contract and add it to the "accounts" array.
    function createAccount(address _owner) external {
        // Create a new instance of the "Account" contract with the given "_owner" and initial balance of 0.
        Account account = new Account(_owner, 0);
        
        // Add the newly created Account contract to the "accounts" array.
        accounts.push(account);
    }

    // Function to create a new Account contract, send ether to it, and add it to the "accounts" array.
    function createAccountAndSendEther(address _owner) external payable {
        // Create a new instance of the "Account" contract with the given "_owner" and transfer the sent ether.
        Account account = (new Account){value: msg.value}(_owner, 0);
        
        // Add the newly created Account contract to the "accounts" array.
        accounts.push(account);
    }

    // Function to create a new Account contract with an initial balance of 1000 wei and add it to the "accounts" array.
    function createSavingsAccount(address _owner) external {
        // Create a new instance of the "Account" contract with the given "_owner" and an initial balance of 1000 wei.
        Account account = (new Account)(_owner, 1000);
        
        // Add the newly created Account contract to the "accounts" array.
        accounts.push(account);
    }
}