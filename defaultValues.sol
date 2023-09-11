// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract DefaultValues {
    // Declaring a Solidity smart contract named "DefaultValues."

    int public i; // Declaring a public signed integer state variable named "i" with a default value of 0.
    // Signed integers can hold both positive and negative numbers, and the default is 0.

    bytes32 public b32; // Declaring a public bytes32 state variable named "b32" with a default value of all zeros.
    // The default value of a bytes32 variable is a 32-byte array filled with zeros.

    address public addr; // Declaring a public Ethereum address state variable named "addr" with a default value of the zero address.
    // The default value of an address is 0x0000000000000000000000000000000000000000.

    uint public u; // Declaring a public unsigned integer state variable named "u" with a default value of 0.
    // Unsigned integers can only hold positive numbers or zero, and the default is 0.

    bool public b; // Declaring a public boolean state variable named "b" with a default value of "false."
    // The default value of a boolean is "false."
}