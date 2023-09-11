// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

/// @title ValueTypes
/// @notice A Solidity smart contract showcasing various value types.
contract ValueTypes {
    bool public b;
    // Declaring a public boolean variable named "b." Booleans can be either true or false.

    int public i = -1;
    // Declaring a public signed integer variable named "i" and initializing it with the value -1.
    // Signed integers can hold both positive and negative numbers.

    uint public u = 123;
    // Declaring a public unsigned integer variable named "u" and initializing it with the value 123.
    // Unsigned integers can only hold positive numbers or zero.

    address public addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    // Declaring a public Ethereum address variable named "addr" and initializing it with a specific Ethereum address.
    // Addresses are used to represent accounts on the Ethereum blockchain.

    bytes32 public b32;
    // Declaring a public fixed-size bytes32 variable named "b32." This can hold 32 bytes of data.

    /// @notice Get the current boolean value.
    /// @return The boolean value.
    function getBool() public view returns (bool) {
        return b;
    }

    /// @notice Get the current signed integer value.
    /// @return The signed integer value.
    function getInt() public view returns (int) {
        return i;
    }

    /// @notice Get the current unsigned integer value.
    /// @return The unsigned integer value.
    function getUint() public view returns (uint) {
        return u;
    }

    /// @notice Get the current Ethereum address.
    /// @return The Ethereum address.
    function getAddress() public view returns (address) {
        return addr;
    }

    /// @notice Get the current bytes32 value.
    /// @return The bytes32 value.
    function getBytes32() public view returns (bytes32) {
        return b32;
    }
}
