// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title VisibilityBase
 * @dev This contract represents a base contract with various visibility modifiers and functions.
 */
contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;

    /**
     * @dev Private function that returns 0.
     * @return An unsigned integer 0.
     */
    function privateFunc() private pure returns (uint) {
        return 0;
    }

    /**
     * @dev Internal function that returns 100.
     * @return An unsigned integer 100.
     */
    function internalFunc() internal pure returns (uint) {
        return 100;
    }

    /**
     * @dev Public function that returns 200.
     * @return An unsigned integer 200.
     */
    function publicFunc() public pure returns (uint) {
        return 200;
    }

    /**
     * @dev External function that returns 300.
     * @return An unsigned integer 300.
     */
    function externalFunc() external pure returns (uint) {
        return 300;
    }

    /**
     * @dev Public external function that demonstrates the usage of various visibility modifiers and functions.
     */
    function examples() external view {
        x + y + z;
        privateFunc();
        internalFunc();
        publicFunc();
        this.externalFunc();
    }
}

/**
 * @title VisibilityChild
 * @dev This contract represents a child contract that inherits from VisibilityBase.
 */
contract VisibilityChild is VisibilityBase {
    /**
     * @dev Public function in the child contract that demonstrates the usage of inherited state variables and functions.
     */
    function examples2() public view {
        y + z;
        internalFunc();
        publicFunc();
    }

    /**
     * @dev Public function in the child contract that returns the sum of inherited state variables and function calls.
     * @return The sum of y, z, internalFunc(), and publicFunc().
     */
    function test() public view returns (uint) {
        return y + z + internalFunc() + publicFunc();
    }
}
