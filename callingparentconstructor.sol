// SPDX-License-Identifier: MIT
// The above comment specifies the license under which these contracts are distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

contract U is S("S"), T("T") {
    // Contract U inherits from contracts S and T and calls their constructors with specific arguments.
    // As a result, U will have the state variables "name" and "text" initialized with "S" and "T," respectively.
    // Both parent contracts' constructors are called in the constructor of U.

}

contract V is S, T {
    // Contract V inherits from contracts S and T but does not provide constructor arguments.
    // Instead, it defines its own constructor that takes two string arguments and initializes both parent contracts.
    
    constructor(string memory _name, string memory _text) S(_name) T(_text) {
        // Here, the constructor of V calls the constructors of S and T with the provided arguments.
        // This allows V to set the state variables "name" and "text" with custom values.
    }
}

contract W is S("S"), T {
    // Contract W inherits from contract S and T, but it calls only the constructor of T with a single argument.
    
    constructor(string memory _s) T(_s) {
        // Here, the constructor of W calls the constructor of T with the provided argument.
        // As a result, W initializes the state variable "text" with the value of _s, and "name" remains "S."
    }
}