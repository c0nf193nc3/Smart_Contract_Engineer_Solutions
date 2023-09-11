// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// This is the base contract 'X'
contract X {
    // The 'foo' function returns the string "X" and is marked as pure.
    function foo() public pure virtual returns (string memory) {
        return "X";
    }

    // The 'bar' function also returns the string "X" and is marked as pure.
    function bar() public pure virtual returns (string memory) {
        return "X";
    }
}

// Contract 'Y' inherits from 'X'
contract Y is X {
    // The 'foo' function overrides the 'foo' function in 'X' and returns the string "Y".
    function foo() public pure virtual override returns (string memory) {
        return "Y";
    }

    // The 'bar' function also overrides the 'bar' function in 'X' and returns the string "Y".
    function bar() public pure virtual override returns (string memory) {
        return "Y";
    }
}

// Contract 'Z' inherits from both 'X' and 'Y'
contract Z is X, Y {
    // The 'foo' function in 'Z' overrides both the 'foo' functions in 'X' and 'Y' and returns the string "Z".
    function foo() public pure override(X, Y) returns (string memory) {
        return "Z";
    }

    // The 'bar' function in 'Z' also overrides both the 'bar' functions in 'X' and 'Y' and returns the string "Z".
    function bar() public pure override(X, Y) returns (string memory) {
        return "Z";
    }
}