// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title ValueTypes
 * @notice A Solidity smart contract showcasing various value types.
 */
contract ValueTypes {
    /**
     * @dev Stores a boolean value.
     * @return The boolean value.
     */
    bool public b;

    /**
     * @dev Stores a signed integer value.
     * @return The signed integer value.
     */
    int public i = -1;

    /**
     * @dev Stores an unsigned integer value.
     * @return The unsigned integer value.
     */
    uint public u = 123;

    /**
     * @dev Stores an Ethereum address.
     * @return The Ethereum address.
     */
    address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    /**
     * @dev Stores a bytes32 value.
     * @return The bytes32 value.
     */
    bytes32 public b32;

    /**
     * @notice Get the current boolean value.
     * @return The boolean value.
     */
    function getBool() public view returns (bool) {
        return b;
    }

    /**
     * @notice Get the current signed integer value.
     * @return The signed integer value.
     */
    function getInt() public view returns (int) {
        return i;
    }

    /**
     * @notice Get the current unsigned integer value.
     * @return The unsigned integer value.
     */
    function getUint() public view returns (uint) {
        return u;
    }

    /**
     * @notice Get the current Ethereum address.
     * @return The Ethereum address.
     */
    function getAddress() public view returns (address) {
        return addr;
    }

    /**
     * @notice Get the current bytes32 value.
     * @return The bytes32 value.
     */
    function getBytes32() public view returns (bytes32) {
        return b32;
    }
}
