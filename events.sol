// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title Event Contract
 * @dev This contract demonstrates the usage of events in Solidity.
 */
contract Event {
    /**
     * @notice Emitted when a generic log message is recorded.
     * @param message The message string.
     * @param val The associated unsigned integer value.
     */
    event Log(string message, uint val);

    /**
     * @notice Emitted when a log message is recorded with an indexed sender.
     * @param sender The sender's address (indexed).
     * @param val The associated unsigned integer value.
     */
    event IndexedLog(address indexed sender, uint val);

    /**
     * @notice Demonstrates emitting the "Log" and "IndexedLog" events with sample data.
     */
    function examples() public {
        emit Log("Foo", 123);
        emit IndexedLog(msg.sender, 123);
    }

    /**
     * @notice Emitted when a message is sent between addresses.
     * @param _from The sender's address.
     * @param _to The recipient's address.
     * @param _message The message content.
     */
    event Message(address _from, address _to, string _message);

    /**
     * @notice Allows users to send messages and logs them as events.
     * @param _addr The recipient's address.
     * @param _message The message content.
     */
    function sendMessage(address _addr, string calldata _message) public {
        emit Message(msg.sender, _addr, _message);
    }
}
