// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title DefaultValues
 * @notice A Solidity smart contract demonstrating default values of state variables.
 */
contract DefaultValues {
    /**
     * @dev Public signed integer state variable with a default value of 0.
     */
    int public i;

    /**
     * @dev Public bytes32 state variable with a default value of all zeros.
     */
    bytes32 public b32;

    /**
     * @dev Public Ethereum address state variable with a default value of the zero address.
     */
    address public addr;

    /**
     * @dev Public unsigned integer state variable with a default value of 0.
     */
    uint public u;

    /**
     * @dev Public boolean state variable with a default value of "false."
     */
    bool public b;
}
