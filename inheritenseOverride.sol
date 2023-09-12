// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title A
 * @dev Contract A defines two functions: `foo` and `bar`.
 */
contract A {
    /**
     * @notice Returns the string "A".
     * @return The string "A".
     */
    function foo() public pure virtual returns (string memory) {
        return "A";
    }

    /**
     * @notice Returns the string "A".
     * @return The string "A".
     */
    function bar() public pure virtual returns (string memory) {
        return "A";
    }
}

/**
 * @title B
 * @dev Contract B inherits from contract A and overrides its functions.
 */
contract B is A {
    /**
     * @notice Overrides the `foo` function from contract A.
     * @return The string "B".
     */
    function foo() public pure override returns (string memory) {
        return "B";
    }
    
    /**
     * @notice Overrides the `bar` function from contract A.
     * @return The string "B".
     */
    function bar() public pure override returns (string memory) {
        return "B";
    }
}
