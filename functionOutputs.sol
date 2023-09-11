// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title FunctionOutputs
 * @notice A Solidity smart contract showcasing various ways of returning multiple values from functions.
 */
contract FunctionOutputs {
    /**
     * @dev Function to return multiple values as a tuple.
     * @notice This function returns a tuple containing a uint and a bool.
     * @return The tuple with values (1, true).
     */
    function returnMany() public pure returns (uint, bool) {
        return (1, true);
    }

    /**
     * @dev Function to return multiple values with named outputs.
     * @notice This function returns a tuple with named outputs "x" and "b."
     * @return The tuple with values (x: 1, b: true).
     */
    function named() public pure returns (uint x, bool b) {
        return (1, true);
    }

    /**
     * @dev Function to return multiple values with named outputs and assignments.
     * @notice This function assigns values to named outputs "x" and "b" before returning them.
     * @return The tuple with values (x: 1, b: true).
     */
    function assigned() public pure returns (uint x, bool b) {
        x = 1;
        b = true;
    }

    /**
     * @dev Function demonstrating destructuring assignment of function outputs.
     * @notice This function calls "returnMany" and assigns its return values to "i" and "b."
     * @notice It also showcases how to ignore left-out values in the tuple during destructuring.
     */
    function destructuringAssigments() public pure {
        (uint i, bool b) = returnMany();

        // Ignoring the first value (uint) from "returnMany" and capturing only the second (bool).
        (, bool a) = returnMany();
    }
    
    /**
     * @dev Function to return an address and a bool.
     * @notice This function returns a tuple containing the sender's address (msg.sender) and false (bool).
     * @return The tuple with values (address: msg.sender, bool: false).
     */
    function myFunc() public view returns (address, bool) {
        return (msg.sender, false);
    }
}
