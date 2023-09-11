// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract ConstructorIntro {
    // Declaring a Solidity smart contract named "ConstructorIntro."

    address public owner; // A public state variable to store the contract owner's address.
    uint public x; // A public state variable to store an unsigned integer value.

    constructor(uint _x) {
        // A constructor function, named the same as the contract, which is executed only once during contract deployment.
        // It takes an unsigned integer argument "_x."

        owner = msg.sender;
        // Assigning the contract's deployer's address (the sender of the deployment transaction) to the "owner" state variable.
        // This effectively sets the contract deployer as the owner.

        x = _x;
        // Assigning the value of the "_x" argument provided during contract deployment to the "x" state variable.
        // This initializes "x" with the provided value.
    }
}