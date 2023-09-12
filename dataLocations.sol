// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

/**
 * @title DataLocations
 * @dev This contract demonstrates data locations in Solidity.
 */
contract DataLocations {
    uint public x;
    uint public arr;

    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    /**
     * @dev Demonstrates data locations.
     * @return memArr A dynamic memory array.
     */
    function examples() public returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});
        MyStruct storage myStruct = myStructs[msg.sender];
        myStruct.text = "baz";

        uint[] memory memArr = new uint[](3);
        memArr[1] = 123;

        return memArr;
    }

    /**
     * @dev Allows setting the "text" field for a specified address.
     * @param _addr The Ethereum address for which to set the "text" field.
     * @param _text The new text value.
     */
    function set(address _addr, string calldata _text) public {
        myStructs[_addr].text = _text;
    }

    /**
     * @dev Retrieves the "text" field for a specified address.
     * @param _addr The Ethereum address for which to retrieve the "text" field.
     * @return text The text value associated with the provided address.
     */
    function get(address _addr) public view returns (string memory text) {
        return myStructs[_addr].text;
    }
}
