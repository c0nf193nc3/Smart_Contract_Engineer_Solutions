// SPDX-License-Identifier: MIT
// The above comment specifies the license under which this contract is distributed.

pragma solidity ^0.8.17;
// Specifies the version of the Solidity compiler to use. In this case, version 0.8.17 or higher is required.

contract DataLocations {
    // Declaring a Solidity smart contract named "DataLocations."

    uint public x;
    // Declaring a public state variable "x" of type uint. State variables have a data location of "storage" by default.

    uint public arr;
    // Declaring another public state variable "arr" of type uint. Also stored in "storage" by default.

    struct MyStruct {
        uint foo;
        string text;
    }
    // Defining a struct named "MyStruct" with two fields: "foo" of type uint and "text" of type string.

    mapping(address => MyStruct) public myStructs;
    // Declaring a public mapping named "myStructs" that associates Ethereum addresses with "MyStruct" values.
    // Mappings store data in "storage" by default.

    function examples() public returns (uint[] memory) {
        // A public function named "examples" that demonstrates data locations.

        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});
        // Initializing the "myStructs" mapping with a "MyStruct" value for the sender's Ethereum address.
        // This operation stores data in "storage."

        MyStruct storage myStruct = myStructs[msg.sender];
        // Creating a reference "myStruct" to the "MyStruct" value associated with the sender's Ethereum address.
        // This is an example of a "storage" reference.

        myStruct.text = "baz";
        // Modifying the "text" field of the referenced "myStruct."
        // Since "myStruct" is a storage reference, this operation modifies data in "storage."

        uint[] memory memArr = new uint[](3);
        // Creating a dynamic memory array "memArr" with a length of 3.
        // This array is stored in "memory."

        memArr[1] = 123;
        // Modifying an element of the "memArr" array.
        // This operation works with data in "memory."

        return memArr;
        // Returning the "memArr" array, which is read from "memory."
    }

    function set(address _addr, string calldata _text) public {
        // A public function named "set" that allows setting the "text" field for a specified address.
        // Notice that "_text" is declared as "calldata" instead of "memory" to minimize gas cost.

        myStructs[_addr].text = _text;
        // Modifying the "text" field of the "MyStruct" associated with the provided address "_addr."
        // This operation interacts with data in "storage."
    }

    function get(address _addr) public view returns (string memory) {
        // A public view function named "get" that retrieves the "text" field for a specified address.

        return myStructs[_addr].text;
        // Returning the "text" field of the "MyStruct" associated with the provided address "_addr."
        // This operation reads data from "storage."
    }
}