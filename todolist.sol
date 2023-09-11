// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract TodoList {
    // Declaring a Solidity smart contract named "TodoList."

    struct Todo {
        string text;
        bool completed;
    }
    // Defining a struct named "Todo" with two fields: "text" (string) and "completed" (bool).

    Todo[] public todos;
    // Declaring a public dynamic array of "Todo" structs to store a list of to-do items.
    // The "public" modifier allows anyone to read the list of to-do items.

    function create(string calldata _text) public {
        // A public function named "create" that allows users to create a new to-do item.
        // It takes a string argument "_text" declared as "calldata."

        todos.push(Todo({text: _text, completed: false}));
        // Creating a new "Todo" struct with the provided text and default completion status (false).
        // The new to-do item is added to the "todos" array.
    }

    function updateText(uint _index, string calldata _text) public {
        // A public function named "updateText" that allows users to update the text of an existing to-do item.
        // It takes the index of the to-do item to update and a new text string as arguments.

        todos[_index].text = _text;
        // Updating the text of the to-do item at the specified index with the provided text.
    }

    function toggleCompleted(uint _index) public {
        // A public function named "toggleCompleted" that allows users to toggle the completion status of a to-do item.
        // It takes the index of the to-do item to toggle.

        todos[_index].completed = !todos[_index].completed;
        // Toggling the completion status of the to-do item at the specified index.
    }

    function get(uint _index) public view returns (string memory, bool) {
        // A public view function named "get" that allows users to retrieve the text and completion status of a to-do item.
        // It takes the index of the to-do item to retrieve.

        return (todos[_index].text, todos[_index].completed);
        // Returning the text and completion status of the to-do item at the specified index.
        // The data is returned as a tuple of a string and a boolean.
    }
}