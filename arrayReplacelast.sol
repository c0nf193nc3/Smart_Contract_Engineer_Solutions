// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract ArrayReplaceLast {
    // Declaring a Solidity smart contract named "ArrayReplaceLast."

    uint[] public arr = [1, 2, 3, 4];
    // Declaring a public dynamic array of unsigned integers named "arr" and initializing it with [1, 2, 3, 4].

    function remove(uint _index) public {
        // A public function named "remove" that allows users to remove an element from the "arr" array.
        // It takes an integer "_index" as an argument, representing the index of the element to remove.

        require(_index < arr.length, "index out of range");
        // Using a "require" statement to ensure that the provided index "_index" is within the valid range of the array.

        arr[_index] = arr[arr.length - 1];
        // Replacing the element at the specified index "_index" with the last element in the array.
        // This effectively moves the last element to the position of the removed element.

        arr.pop();
        // Using the "pop" function to remove the last element from the array.
        // Since we have already replaced the element at the specified index, this effectively removes the desired element.
    }
}