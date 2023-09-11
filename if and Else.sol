// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title IfElse
 * @notice A Solidity smart contract showcasing conditional statements and ternary operators.
 */
contract IfElse {
    /**
     * @dev Function demonstrating if-else conditional statements.
     * @param _x The input unsigned integer.
     * @return 1 if _x < 10, 2 if 10 <= _x < 20, and 3 otherwise.
     */
    function ifElse(uint _x) public pure returns (uint) {
        if (_x < 10) {
            return 1;
        } else if (_x < 20) {
            return 2;
        } else {
            return 3;
        }
    }

    /**
     * @dev Function demonstrating the ternary operator.
     * @param _x The input unsigned integer.
     * @return 10 if _x > 5, otherwise 20.
     */
    function ternaryOperator(uint _x) public pure returns (uint) {
        return _x > 5 ? 10 : 20;
    }

    /**
     * @dev Exercise 1: Using if-else to check if _x is greater than 0.
     * @param _x The input unsigned integer.
     * @return 1 if _x > 0, otherwise 0.
     */
    function exercise_1(uint _x) public pure returns (uint) {
        if (_x > 0) {
            return 1;
        } else {
            return 0;
        }
    }

    /**
     * @dev Exercise 2: Using the ternary operator to check if _x is greater than 0.
     * @param _x The input unsigned integer.
     * @return 1 if _x > 0, otherwise 0.
     */
    function exercise_2(uint _x) public pure returns (uint) {
        return _x > 0 ? 1 : 0;
    }
}
