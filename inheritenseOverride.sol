// SPDX-License-Identifier: MIT
// The above comment specifies the license under which these contracts are distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract A {
    function foo() public pure virtual returns (string memory) {
        // The `virtual` keyword allows this function to be overridden by child contracts.
        return "A";
    }

    function bar() public pure virtual returns (string memory) {
        return "A";
    }
}

contract B is A {
    // Inherit from contract A using the keyword 'is'.

    // Overrides the foo() function from contract A.
    function foo() public pure override returns (string memory) {
        return "B";
    }
    
    // Overrides the bar() function from contract A.
    function bar() public pure override returns (string memory) {
        return "B";
    }
}