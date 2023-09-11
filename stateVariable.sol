// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title StateVariables
 * @notice A Solidity smart contract demonstrating state variables and functions.
 */
contract StateVariables {
    /**
     * @dev Public unsigned integer state variable.
     */
    uint public num;

    /**
     * @dev Set the value of the state variable.
     * @param _num The new value to set.
     */
    function setNum(uint _num) external {
        num = _num;
    }

    /**
     * @dev Get the current value of the state variable.
     * @return The current value of 'num'.
     */
    function getNum() public view returns (uint) {
        return num;
    }

    /**
     * @dev Reset the state variable to zero.
     */
    function resetNum() public {
        num = 0;
    }

    /**
     * @dev Get the current value of 'num' incremented by one.
     * @return The value of 'num' plus one.
     */
    function getNumPlusOne() public view returns (uint) {
        return num + 1;
    }
}
