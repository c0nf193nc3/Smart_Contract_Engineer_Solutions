// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract SendEther {
    // Declaring a Solidity smart contract named "SendEther."

    receive() external payable {
        // The receive function, declared as external and payable.
        // This function is executed when the contract receives Ether with a simple transfer, such as "address.transfer(value)".
    }
    
    function sendViaTransfer(address payable _to) external payable {
        // A public external function "sendViaTransfer" for sending Ether using the "transfer" method.
        // This method is used to send Ether to the specified address "_to" using the "transfer" function.

        _to.transfer(msg.value);
        // The "msg.value" represents the amount of Ether being sent with the function call.
        // The "transfer" function sends the Ether and reverts the transaction if it fails.
    }

    function sendViaSend(address payable _to) external payable {
        // A public external function "sendViaSend" for sending Ether using the "send" method.
        // This method is used to send Ether to the specified address "_to" using the "send" function.

        bool sent = _to.send(msg.value);
        // The "msg.value" represents the amount of Ether being sent with the function call.
        // The "send" function returns a boolean indicating success or failure.

        require(sent, "Failed to send Ether");
        // If the send operation fails, the contract reverts with an error message.
    }

    function sendViaCall(address payable _to) external payable {
        // A public external function "sendViaCall" for sending Ether using the "call" method.
        // This method is recommended for sending Ether as it provides more control and flexibility.

        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        // Using the "call" function with the "value" field to send Ether to the specified address "_to."
        // It returns a tuple with a boolean indicating success and a data field (usually empty for simple Ether transfers).

        require(sent, "Failed to send Ether");
        // If the call operation fails, the contract reverts with an error message.
    }
    
    function sendEth(address payable _to, uint _amount) external {
        // A public external function "sendEth" for sending a specific amount of Ether to the specified address "_to."

        (bool sent, ) = _to.call{value: _amount}("");
        // Using the "call" function with the "value" field to send the specified "_amount" of Ether.

        require(sent, "Failed to send Ether");
        // If the call operation fails, the contract reverts with an error message.
    }
}