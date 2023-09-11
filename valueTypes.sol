// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract ValueTypes {
    // Declaring a Solidity smart contract named "ValueTypes."

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

    // This contract showcases various value types in Solidity.
}
