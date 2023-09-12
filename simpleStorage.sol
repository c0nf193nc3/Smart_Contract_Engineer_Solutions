// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title SimpleStorage
 * @dev This contract demonstrates a simple storage contract in Solidity.
 */
contract SimpleStorage {
    string public text;

    /**
     * @dev Allows setting the value of the "text" variable.
     * @param _text The new value to set.
     */
    function set(string calldata _text) public {
        text = _text;
    }

    /**
     * @dev Allows retrieving the current value of the "text" variable.
     * @return The current value of the "text" variable.
     */
    function get() public view returns (string memory) {
        return text;
    }
}
