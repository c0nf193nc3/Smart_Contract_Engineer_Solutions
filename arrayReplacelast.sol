// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title ArrayReplaceLast
 * @dev This contract demonstrates replacing the last element in a Solidity dynamic array when removing an element.
 */
contract ArrayReplaceLast {
    uint[] public arr = [1, 2, 3, 4];

    /**
     * @dev Allows users to remove an element from the "arr" array.
     * @param _index The index of the element to remove.
     */
    function remove(uint _index) public {
        require(_index < arr.length, "index out of range");

        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }
}
