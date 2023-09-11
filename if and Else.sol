// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract IfElse {
    // Declaring a Solidity smart contract named "IfElse."

    function ifElse(uint _x) public pure returns (uint) {
        // Declaring a public pure function named "ifElse" that takes an unsigned integer argument "_x."

        if (_x < 10) {
            return 1;
        } else if (_x < 20) {
            return 2;
        } else {
            return 3;
        }
        // This function uses an if-else if-else conditional statement to determine the return value based on the value of "_x."
        // If "_x" is less than 10, it returns 1.
        // If "_x" is between 10 (inclusive) and 20 (exclusive), it returns 2.
        // Otherwise, it returns 3.
    }

    function ternaryOperator(uint _x) public pure returns (uint) {
        // Declaring a public pure function named "ternaryOperator" that takes an unsigned integer argument "_x."

        return _x > 5 ? 10 : 20;
        // This function uses the ternary operator to determine the return value based on the condition "_x > 5."
        // If "_x" is greater than 5, it returns 10; otherwise, it returns 20.
        // The ternary operator format is: condition ? value_if_true : value_if_false.
    }

    function exercise_1(uint _x) public pure returns (uint) {
        // Declaring a public pure function named "exercise_1" that takes an unsigned integer argument "_x."

        if (_x > 0) {
            return 1;
        } else {
            return 0;
        }
        // This function uses a traditional if-else statement to check if "_x" is greater than 0.
        // If it is, it returns 1; otherwise, it returns 0.
    }

    function exercise_2(uint _x) public pure returns (uint) {
        // Declaring a public pure function named "exercise_2" that takes an unsigned integer argument "_x."

        return _x > 0 ? 1 : 0;
        // This function uses the ternary operator to achieve the same result as "exercise_1."
        // If "_x" is greater than 0, it returns 1; otherwise, it returns 0.
    }
}