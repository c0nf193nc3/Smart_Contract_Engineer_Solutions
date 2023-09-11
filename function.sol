// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title FunctionIntro
 * @notice A Solidity smart contract showcasing basic arithmetic functions.
 */
contract FunctionIntro {
    /**
     * @dev Adds two unsigned integers.
     * @param x The first unsigned integer.
     * @param y The second unsigned integer.
     * @return The result of the addition.
     */
    function add(uint x, uint y) public pure returns (uint) {
        return x + y;
    }
    
    /**
     * @dev Subtracts one unsigned integer from another.
     * @param x The first unsigned integer.
     * @param y The second unsigned integer to subtract from the first.
     * @return The result of the subtraction.
     */
    function sub(uint x, uint y) public pure returns (uint) {
        return x - y;
    }
}
