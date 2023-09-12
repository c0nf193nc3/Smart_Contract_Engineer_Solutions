// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title ArrayShift
 * @dev This contract demonstrates shifting elements in a Solidity dynamic array.
 */
contract ArrayShift {
    uint[] public arr = [1, 2, 3];

    /**
     * @dev Allows users to remove an element from the "arr" array.
     * @param _index The index of the element to remove.
     */
    function remove(uint _index) public {
        require(_index < arr.length, "index out of range");

        for (uint i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }

        arr.pop();
    }
}
