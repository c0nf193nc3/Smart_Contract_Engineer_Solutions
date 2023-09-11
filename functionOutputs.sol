// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract FunctionOutputs {
    // Declaring a Solidity smart contract named "FunctionOutputs."

    function returnMany() public pure returns (uint, bool) {
        // A public pure function named "returnMany" that returns multiple values (a uint and a bool).

        return (1, true);
        // This function returns a tuple containing two values: 1 (uint) and true (bool).
    }

    function named() public pure returns (uint x, bool b) {
        // A public pure function named "named" that returns multiple values with named outputs.

        return (1, true);
        // This function returns a tuple containing two values: 1 (assigned to "x") and true (assigned to "b").
    }

    function assigned() public pure returns (uint x, bool b) {
        // A public pure function named "assigned" that returns multiple values with named outputs.

        x = 1;
        b = true;
        // This function assigns values to the named outputs "x" and "b" before returning them.
    }

    function destructuringAssigments() public pure {
        // A public pure function named "destructuringAssigments" that demonstrates destructuring assignment of function outputs.

        (uint i, bool b) = returnMany();
        // This line calls the "returnMany" function and assigns its return values to "i" and "b."
        // The values are unused in this example, but it showcases how to destructure the return values.

        // Left out values in the tuple can be ignored during destructuring.
        (, bool a) = returnMany();
        // Here, we only capture the second value (bool) from the "returnMany" function and ignore the first (uint).
    }
    
    function myFunc() public view returns (address, bool) {
        // A public view function named "myFunc" that returns an address and a bool.

        return (msg.sender, false);
        // This function returns a tuple containing two values: the sender's address (msg.sender) and false (bool).
    }
}