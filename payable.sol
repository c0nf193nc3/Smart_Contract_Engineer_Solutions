// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title Payable
 * @dev This contract represents a payable contract with an 'owner' state variable.
 * The 'owner' variable is declared as 'payable', allowing it to receive Ether.
 */
contract Payable {
    address payable public owner;

    /**
     * @dev Constructor for the Payable contract.
     * Initializes the 'owner' state variable with the address of the contract deployer.
     * This constructor is marked as 'payable', indicating that the contract can receive Ether upon deployment.
     */
    constructor() payable {
        owner = payable(msg.sender);
    }

    /**
     * @dev External function 'deposit' that allows users to send Ether to the contract.
     * This function is marked as 'payable', indicating that it can receive Ether when called.
     * Users can deposit Ether into the contract using this function.
     */
    function deposit() external payable {
        // Users can deposit Ether into the contract using this function.
    }
}
