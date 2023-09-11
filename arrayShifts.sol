// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract ArrayShift {
    // Declaring a Solidity smart contract named "ArrayShift."

    uint[] public arr = [1, 2, 3];
    // Declaring a public dynamic array of unsigned integers named "arr" and initializing it with [1, 2, 3].

    function remove(uint _index) public {
        // A public function named "remove" that allows users to remove an element from the "arr" array.
        // It takes an integer "_index" as an argument, representing the index of the element to remove.

        require(_index < arr.length, "index out of range");
        // Using a "require" statement to ensure that the provided index "_index" is within the valid range of the array.

        for (uint i = _index; i < arr.length - 1; i++) {
            // Starting a loop from the provided index "_index" and iterating up to the second-to-last element in the array.
            // This loop is used to shift elements to the left to fill the gap left by the removed element.

            arr[i] = arr[i + 1];
            // Shifting the element at the current index "i" to the left by copying the value of the next element (i + 1).
        }

        arr.pop();
        // Using the "pop" function to remove the last element from the array.
        // Since we have already shifted elements to the left, this effectively removes the element at the specified index.
    }
}