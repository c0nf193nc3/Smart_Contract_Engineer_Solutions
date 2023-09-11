// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title ViewAndPureFunctions
 * @notice A Solidity smart contract showcasing view and pure functions.
 */
contract ViewAndPureFunctions {
    /**
     * @dev Public unsigned integer state variable.
     */
    uint public num;

    /**
     * @dev Function to view the current value of 'num'.
     * @return The current value of 'num'.
     */
    function viewFunc() public view returns (uint) {
        return num;
    }

    /**
     * @dev Function to demonstrate a pure function.
     * @return The constant value 1.
     */
    function pureFunc() public pure returns (uint) {
        return 1;
    }
    
    /**
     * @dev Function to add a value to 'num'.
     * @param x The value to add to 'num'.
     * @return The result of adding 'x' to 'num'.
     */
    function addToNum(uint x) public view returns (uint) {
        return num + x;
    }
    
    /**
     * @dev Function to add two numbers.
     * @param x The first number to add.
     * @param y The second number to add.
     * @return The result of adding 'x' and 'y'.
     */
    function add(uint x, uint y) public pure returns (uint) {
        return x + y;
    }
}
