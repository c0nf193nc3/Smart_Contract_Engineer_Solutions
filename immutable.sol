// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title Immutable
 * @dev This contract represents an immutable contract with an 'owner' state variable.
 * The 'owner' variable can only be set once during contract deployment.
 */
contract Immutable {
    address public immutable owner;

    /**
     * @dev Constructor for the Immutable contract.
     * Sets the 'owner' state variable to the address of the contract deployer.
     */
    constructor() {
        owner = msg.sender;
        // The 'immutable' keyword ensures that 'owner' can only be set once during contract creation.
    }
}
