// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title S
 * @dev This contract represents contract S and contains a public state variable 'name'.
 */
contract S {
    string public name;

    /**
     * @dev Constructor for contract S.
     * @param _name The initial value for the 'name' state variable.
     */
    constructor(string memory _name) {
        name = _name;
    }
}

/**
 * @title T
 * @dev This contract represents contract T and contains a public state variable 'text'.
 */
contract T {
    string public text;

    /**
     * @dev Constructor for contract T.
     * @param _text The initial value for the 'text' state variable.
     */
    constructor(string memory _text) {
        text = _text;
    }
}

/**
 * @title U
 * @dev This contract inherits from contracts S and T and initializes their state variables.
 */
contract U is S("S"), T("T") {
    // No additional functionality is provided in this contract.
}

/**
 * @title V
 * @dev This contract inherits from contracts S and T and initializes their state variables using a custom constructor.
 */
contract V is S, T {
    /**
     * @dev Constructor for contract V.
     * @param _name The initial value for the 'name' state variable.
     * @param _text The initial value for the 'text' state variable.
     */
    constructor(string memory _name, string memory _text) S(_name) T(_text) {
        // Constructor initializes state variables 'name' and 'text' with custom values.
    }
}

/**
 * @title W
 * @dev This contract inherits from contract S and T, initializing the 'text' state variable.
 */
contract W is S("S"), T {
    /**
     * @dev Constructor for contract W.
     * @param _s The initial value for the 'text' state variable.
     */
    constructor(string memory _s) T(_s) {
        // Constructor initializes the 'text' state variable with a custom value while 'name' remains "S".
    }
}
