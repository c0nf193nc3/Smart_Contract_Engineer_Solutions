// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title X
 * @dev This is the base contract 'X' defining two functions: 'foo' and 'bar'.
 */
contract X {
    /**
     * @notice Returns the string "X".
     * @return The string "X".
     */
    function foo() public pure virtual returns (string memory) {
        return "X";
    }

    /**
     * @notice Returns the string "X".
     * @return The string "X".
     */
    function bar() public pure virtual returns (string memory) {
        return "X";
    }
}

/**
 * @title Y
 * @dev Contract 'Y' inherits from 'X' and overrides its functions.
 */
contract Y is X {
    /**
     * @notice Overrides the 'foo' function in 'X' and returns the string "Y".
     * @return The string "Y".
     */
    function foo() public pure virtual override returns (string memory) {
        return "Y";
    }

    /**
     * @notice Overrides the 'bar' function in 'X' and returns the string "Y".
     * @return The string "Y".
     */
    function bar() public pure virtual override returns (string memory) {
        return "Y";
    }
}

/**
 * @title Z
 * @dev Contract 'Z' inherits from both 'X' and 'Y' and overrides their functions.
 */
contract Z is X, Y {
    /**
     * @notice Overrides both the 'foo' functions in 'X' and 'Y' and returns the string "Z".
     * @return The string "Z".
     */
    function foo() public pure override(X, Y) returns (string memory) {
        return "Z";
    }

    /**
     * @notice Overrides both the 'bar' functions in 'X' and 'Y' and returns the string "Z".
     * @return The string "Z".
     */
    function bar() public pure override(X, Y) returns (string memory) {
        return "Z";
    }
}
