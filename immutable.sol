// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract Immutable {
    // Declaring a Solidity smart contract named "Immutable."

    address public immutable owner;
    // Declaring a public state variable named "owner" with the `immutable` keyword.
    // The `immutable` keyword indicates that this variable's value can only be set once during contract deployment.

    constructor() {
        // A constructor function that is executed once during contract deployment.

        owner = msg.sender;
        // Assigning the address of the sender (creator of the contract) to the "owner" state variable.
        // Since "owner" is declared as `immutable`, its value can only be set once during contract creation.
    }
}