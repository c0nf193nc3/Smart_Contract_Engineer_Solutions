// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title ErrorHandling
 * @notice A Solidity smart contract showcasing error handling mechanisms.
 */
contract ErrorHandling {
    /**
     * @dev Function demonstrating the "require" statement.
     * @param _i The input unsigned integer.
     * @notice This function uses "require" to validate that _i is not greater than 10.
     * @notice If _i > 10, it reverts the transaction with the error message "i > 10."
     */
    function testRequire(uint _i) public pure {
        require(_i <= 10, "i > 10");
    }

    /**
     * @dev Function demonstrating the "revert" statement.
     * @param _i The input unsigned integer.
     * @notice This function uses "revert" to check if _i is greater than 10.
     * @notice If _i > 10, it reverts the transaction with the error message "i > 10."
     */
    function testRevert(uint _i) public pure {
        if (_i > 10) {
            revert("i > 10");
        }
    }

    uint num;

    /**
     * @dev Function demonstrating the "assert" statement.
     * @notice This function uses "assert" to check if "num" is equal to 0.
     * @notice It should only be used to test for internal errors, bugs, or invariant conditions.
     */
    function testAssert() public view {
        assert(num == 0);
    }

    /**
     * @dev Function demonstrating error handling for division by zero.
     * @param x The numerator (unsigned integer).
     * @param y The denominator (unsigned integer).
     * @return The result of dividing x by y.
     * @notice This function uses "require" to ensure y is greater than 0 to avoid division by zero.
     */
    function div(uint x, uint y) public pure returns (uint) {
        require(y > 0, "div by 0");
        return x / y;
    }
}
