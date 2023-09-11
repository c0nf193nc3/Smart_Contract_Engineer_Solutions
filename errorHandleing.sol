// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract ErrorHandling {
    // Declaring a Solidity smart contract named "ErrorHandling."

    function testRequire(uint _i) public pure {
        // Declaring a public pure function named "testRequire" that takes an unsigned integer argument "_i."

        // Require should be used to validate conditions such as:
        // - Inputs
        // - Conditions before execution
        // - Return values from calls to other functions

        require(_i <= 10, "i > 10");
        // Using the "require" statement to check a condition. If the condition is false, it will revert the transaction
        // and provide an error message "i > 10." This is used to validate that "_i" is not greater than 10.
    }

    function testRevert(uint _i) public pure {
        // Declaring a public pure function named "testRevert" that takes an unsigned integer argument "_i."

        // Revert is useful when the condition to check is complex.
        // This code does the exact same thing as the example above using "revert."

        if (_i > 10) {
            revert("i > 10");
            // Using "revert" to check a condition. If the condition is true, it will revert the transaction
            // and provide an error message "i > 10." This is another way to validate that "_i" is not greater than 10.
        }
    }

    uint num;

    function testAssert() public view {
        // Declaring a public view function named "testAssert."

        // Assert should only be used to test for internal errors, bugs, and to check invariants or conditions
        // that are expected to be true always.

        assert(num == 0);
        // Using "assert" to check an internal condition. If the condition is false, it will throw an error.
        // In this case, it checks if the value of the "num" state variable is equal to 0.
    }

    function div(uint x, uint y) public pure returns (uint) {
        // Declaring a public pure function named "div" that takes two unsigned integer arguments, "x" and "y," and returns an unsigned integer.

        require(y > 0, "div by 0");
        // Using "require" to ensure that "y" is greater than 0 to avoid division by zero.

        return x / y;
        // Performing the division operation and returning the result.
    }
}