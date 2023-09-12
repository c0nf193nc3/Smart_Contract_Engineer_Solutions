// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title TodoList
 * @dev This contract represents a simple to-do list in Solidity.
 */
contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    /**
     * @dev Allows users to create a new to-do item.
     * @param _text The text of the new to-do item.
     */
    function create(string calldata _text) public {
        todos.push(Todo({text: _text, completed: false}));
    }

    /**
     * @dev Allows users to update the text of an existing to-do item.
     * @param _index The index of the to-do item to update.
     * @param _text The new text for the to-do item.
     */
    function updateText(uint _index, string calldata _text) public {
        todos[_index].text = _text;
    }

    /**
     * @dev Allows users to toggle the completion status of a to-do item.
     * @param _index The index of the to-do item to toggle.
     */
    function toggleCompleted(uint _index) public {
        todos[_index].completed = !todos[_index].completed;
    }

    /**
     * @dev Allows users to retrieve the text and completion status of a to-do item.
     * @param _index The index of the to-do item to retrieve.
     * @return text The text of the to-do item.
     * @return completed The completion status of the to-do item.
     */
    function get(uint _index) public view returns (string memory text, bool completed) {
        return (todos[_index].text, todos[_index].completed);
    }
}
