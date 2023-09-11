// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract ArrayBasic {
    // Declaring a Solidity smart contract named "ArrayBasic."

    uint[] public arr; // A public dynamic array of unsigned integers.
    uint[] public arr2 = [1, 2, 3]; // A public dynamic array with initial values [1, 2, 3].

    uint[3] public arrFixedSize; // A public fixed-size array of unsigned integers with length 3, initialized to [0, 0, 0].

    function examples() public {
        // A public function named "examples" that demonstrates various array operations.

        arr.push(1); // Adding an element "1" to the dynamic array "arr."

        uint first = arr[0]; // Reading the first element of the dynamic array "arr."

        arr[0] = 123; // Assigning the value "123" to the first element of the dynamic array "arr."

        delete arr[0]; // Deleting the first element of the dynamic array "arr" (resets the value to the default).

        arr.push(1); // Adding an element "1" to the dynamic array "arr."
        arr.push(2); // Adding an element "2" to the dynamic array "arr."

        arr.pop(); // Removing the last element from the dynamic array "arr."

        uint len = arr.length; // Getting the length of the dynamic array "arr."

        uint[] memory a = new uint[](3); // Creating a memory-based dynamic array "a" with a length of 3.
        a[0] = 1; // Assigning a value to the first element of the memory-based array "a."
        // Note: Memory-based arrays do not support push and pop operations.
    }

    function get(uint i) public view returns (uint) {
        // A public view function named "get" that retrieves the value at a specified index "i" in the dynamic array "arr."

        return arr[i];
    }

    function push(uint x) public {
        // A public function named "push" that adds an element "x" to the end of the dynamic array "arr."

        arr.push(x);
    }

    function remove(uint i) public {
        // A public function named "remove" that deletes the element at a specified index "i" in the dynamic array "arr."

        delete arr[i];
        // Note: Deletion only resets the value to the default (zero for uint).
    }

    function getLength() public view returns (uint) {
        // A public view function named "getLength" that retrieves the length of the dynamic array "arr."

        return arr.length;
    }
}