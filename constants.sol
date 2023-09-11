// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract Constants {
    // Declaring a Solidity smart contract named "Constants."

    address public constant MY_ADDR =
        0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    // Declaring a public constant Ethereum address variable named "MY_ADDR."
    // The constant value is the specified Ethereum address.

    uint public constant MY_UINT = 123;
    // Declaring a public constant unsigned integer variable named "MY_UINT."
    // The constant value is 123.

    // Constants in Solidity are variables with values that cannot be changed after deployment.
    // They are useful for storing values that should remain fixed throughout the contract's lifetime.
}