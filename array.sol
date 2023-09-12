// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title ArrayBasic
 * @dev This contract demonstrates basic array operations in Solidity.
 */
contract ArrayBasic {
    uint[] public arr;
    uint[] public arr2 = [1, 2, 3];
    uint[3] public arrFixedSize;

    /**
     * @dev Demonstrates various array operations.
     */
    function examples() public {
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

    /**
     * @dev Retrieves the value at a specified index in the dynamic array "arr."
     * @param i The index of the element to retrieve.
     * @return The value at the specified index.
     */
    function get(uint i) public view returns (uint) {
        return arr[i];
    }

    /**
     * @dev Adds an element "x" to the end of the dynamic array "arr."
     * @param x The element to add.
     */
    function push(uint x) public {
        arr.push(x);
    }

    /**
     * @dev Deletes the element at a specified index in the dynamic array "arr."
     * @param i The index of the element to delete.
     * Note: Deletion only resets the value to the default (zero for uint).
     */
    function remove(uint i) public {
        delete arr[i];
    }

    /**
     * @dev Retrieves the length of the dynamic array "arr."
     * @return The length of the dynamic array.
     */
    function getLength() public view returns (uint) {
        return arr.length;
    }
}
