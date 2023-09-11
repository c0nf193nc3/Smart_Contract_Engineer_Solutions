// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract Event {
    // Declaring a Solidity smart contract named "Event."

    event Log(string message, uint val);
    // Declaring an event named "Log" with two parameters: a string "message" and an unsigned integer "val."
    // This event is used to log arbitrary messages along with an associated value.

    event IndexedLog(address indexed sender, uint val);
    // Declaring another event named "IndexedLog" with an indexed address parameter "sender" and an unsigned integer "val."
    // Indexing an event parameter allows for more efficient searches and filtering when querying the event logs.

    function examples() public {
        // A public function named "examples" that demonstrates the usage of events.
        // It emits both "Log" and "IndexedLog" events with sample data.

        emit Log("Foo", 123);
        // Emitting a "Log" event with the message "Foo" and the value 123.
        
        emit IndexedLog(msg.sender, 123);
        // Emitting an "IndexedLog" event with the sender's address (indexed) and the value 123.
    }
    
    event Message(address _from, address _to, string _message);
    // Declaring another event named "Message" with three parameters: "_from" (address), "_to" (address), and "_message" (string).
    // This event is designed to log messages sent between addresses.

    function sendMessage(address _addr, string calldata _message) public {
        // A public function named "sendMessage" that allows users to send messages and logs them as events.
        // It takes two arguments: "_addr" (address) representing the recipient's address and "_message" (string) representing the message.

        emit Message(msg.sender, _addr, _message);
        // Emitting a "Message" event to log the sender's address, recipient's address, and the message content.
    }
}