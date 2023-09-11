// SPDX-License-Identifier: MIT
// The above comment specifies the license under which these contracts are distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo(); // Calls E.foo() from the parent contract E.
    }

    function bar() public virtual override {
        emit Log("F.bar");
        super.bar(); // Calls E.bar() from the parent contract E using super.
    }
}

contract G is E {
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo(); // Calls E.foo() from the parent contract E.
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar(); // Calls E.bar() from the parent contract E using super.
    }
}

contract H is F, G {
    function foo() public override(F, G) {
        // Calls G.foo() and then E.foo()
        // Inside F and G, E.foo() is called. Solidity is smart enough
        // to not call E.foo() twice. Hence E.foo() is only called by G.foo().
        super.foo();
    }

    function bar() public override(F, G) {
        super.bar(); // Calls E.bar() from the parent contract E.
    }
}