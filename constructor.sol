// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title ConstructorIntro
 * @notice A Solidity smart contract with a constructor for initialization.
 */
contract ConstructorIntro {
    address public owner; // A public state variable to store the contract owner's address.
    uint public x; // A public state variable to store an unsigned integer value.

    /**
     * @dev Constructor for initializing the contract.
     * @param _x The initial value to set for the "x" state variable.
     * @notice This constructor is executed once during contract deployment.
     * @notice It sets the contract deployer as the owner and initializes "x" with the provided value.
     */
    constructor(uint _x) {
        owner = msg.sender;
        x = _x;
    }
}
