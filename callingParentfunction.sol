// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title E
 * @dev This contract represents contract E and contains two virtual functions and an event 'Log'.
 */
contract E {
    event Log(string message);

    /**
     * @dev Function foo in contract E.
     * Emits a 'Log' event with the message "E.foo".
     */
    function foo() public virtual {
        emit Log("E.foo");
    }

    /**
     * @dev Function bar in contract E.
     * Emits a 'Log' event with the message "E.bar".
     */
    function bar() public virtual {
        emit Log("E.bar");
    }
}

/**
 * @title F
 * @dev This contract inherits from contract E and overrides its functions.
 */
contract F is E {
    /**
     * @dev Overrides function 'foo' from contract E.
     * Emits a 'Log' event with the message "F.foo" and calls 'foo' from contract E.
     */
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo(); // Calls E.foo() from the parent contract E.
    }

    /**
     * @dev Overrides function 'bar' from contract E.
     * Emits a 'Log' event with the message "F.bar" and calls 'bar' from contract E using super.
     */
    function bar() public virtual override {
        emit Log("F.bar");
        super.bar(); // Calls E.bar() from the parent contract E using super.
    }
}

/**
 * @title G
 * @dev This contract also inherits from contract E and overrides its functions.
 */
contract G is E {
    /**
     * @dev Overrides function 'foo' from contract E.
     * Emits a 'Log' event with the message "G.foo" and calls 'foo' from contract E.
     */
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo(); // Calls E.foo() from the parent contract E.
    }

    /**
     * @dev Overrides function 'bar' from contract E.
     * Emits a 'Log' event with the message "G.bar" and calls 'bar' from contract E using super.
     */
    function bar() public virtual override {
        emit Log("G.bar");
        super.bar(); // Calls E.bar() from the parent contract E using super.
    }
}

/**
 * @title H
 * @dev This contract inherits from both contract F and contract G, and it overrides their functions.
 */
contract H is F, G {
    /**
     * @dev Overrides function 'foo' from contracts F and G.
     * Calls 'foo' from contract G and then 'foo' from contract E.
     * Inside F and G, E.foo() is called, so it is only called once in the chain.
     */
    function foo() public override(F, G) {
        super.foo();
    }

    /**
     * @dev Overrides function 'bar' from contracts F and G.
     * Calls 'bar' from contract E.
     */
    function bar() public override(F, G) {
        super.bar(); // Calls E.bar() from the parent contract E.
    }
}
