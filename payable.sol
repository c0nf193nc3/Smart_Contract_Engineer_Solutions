// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract Payable {
    // Declaring a Solidity smart contract named "Payable."

    address payable public owner;
    // Declaring a public state variable named "owner" with the `payable` keyword.
    // The `payable` keyword indicates that this address can receive Ether.

    constructor() payable {
        // A constructor function that is executed once during contract deployment.
        // The `payable` constructor indicates that this contract can receive Ether upon deployment.

        owner = payable(msg.sender);
        // Assigning the sender's address (creator of the contract) to the "owner" state variable.
        // The "owner" is declared as `payable`, allowing it to receive Ether.
    }

    function deposit() external payable {
        // A public external function named "deposit" that allows users to send Ether to the contract.
        // This function is marked as `payable`, indicating that it can receive Ether when called.
        // Users can deposit Ether into the contract using this function.
    }
}
