// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title Ownable
 * @notice A Solidity smart contract that implements ownership functionality.
 */
contract Ownable {
    address public owner; // A public state variable to store the contract owner's address.

    /**
     * @dev Constructor for initializing ownership.
     * @notice This constructor is executed once during contract deployment.
     * @notice It sets the contract deployer as the initial owner.
     */
    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Modifier to restrict access to the owner only.
     * @notice Functions with this modifier can only be executed by the contract owner.
     * @notice If called by an address other than the owner, it will revert with the message "not owner."
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    /**
     * @dev Function to transfer ownership to a new address.
     * @param _newOwner The address to become the new owner.
     * @notice Only the current owner can call this function.
     * @notice It requires that the new owner's address is not the zero address.
     * @notice After successful execution, the ownership is transferred to the new address.
     */
    function setOwner(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "new owner = zero address");
        owner = _newOwner;
    }
}
