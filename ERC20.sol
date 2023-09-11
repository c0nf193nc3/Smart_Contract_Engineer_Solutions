// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Import the interface for the ERC20 token standard.
import "./IERC20.sol";

// Contract definition for an ERC20 token.
contract ERC20 is IERC20 {
    // Total supply of tokens.
    uint public totalSupply = 1000;
    
    // Mapping to track balances of token holders.
    mapping(address => uint) public balanceOf;
    
    // Mapping to track allowances for token spending.
    mapping(address => mapping(address => uint)) public allowance;
    
    // Token name.
    string public name = "TestToken";
    
    // Token symbol.
    string public symbol = "TEST";
    
    // Number of decimal places for token amounts.
    uint8 public decimals = 18;

    // Constructor to initialize the contract and allocate initial supply to the contract creator.
    constructor() {
        balanceOf[msg.sender] = totalSupply;
    }

    // Function to transfer tokens from the caller to another address.
    function transfer(address recipient, uint amount) external returns (bool) {
        // Check if the caller has a sufficient balance to perform the transfer.
        require(balanceOf[msg.sender] >= amount, "insufficient balance");
        
        // Update balances for sender and recipient.
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        
        // Emit a Transfer event to log the transfer.
        emit Transfer(msg.sender, recipient, amount);
        
        return true;
    }

    // Function to approve an address to spend a certain amount of tokens on behalf of the caller.
    function approve(address spender, uint amount) external returns (bool) {
        // Update the allowance mapping for the caller and spender.
        allowance[msg.sender][spender] = amount;
        
        // Emit an Approval event to log the approval.
        emit Approval(msg.sender, spender, amount);
        
        return true;
    }

    // Function to transfer tokens from one address to another, with approval.
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool) {
        // Check if the sender has a sufficient balance to perform the transfer.
        require(balanceOf[sender] >= amount, "insufficient balance");
        
        // Check if the sender is allowed to spend the specified amount on behalf of the caller.
        require(allowance[sender][msg.sender] >= amount, "out of allowance");
        
        // Update allowances and balances for sender and recipient.
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        
        // Emit a Transfer event to log the transfer.
        emit Transfer(sender, recipient, amount);
        
        return true;
    }
    
    // Function to mint (create) new tokens. (Not part of the ERC20 standard but common in many tokens)
    function mint(uint amount) external {
        // Increase the balance of the caller and the total supply.
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        
        // Emit a Transfer event to log the minting.
        emit Transfer(address(0), msg.sender, amount);
    }

    // Function to burn (destroy) tokens. (Not part of the ERC20 standard but common in many tokens)
    function burn(uint amount) external {
        // Check if the caller has a sufficient balance to perform the burn.
        require(balanceOf[msg.sender] >= amount, "insufficient balance");
        
        // Decrease the balance of the caller and the total supply.
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        
        // Emit a Transfer event to log the burning.
        emit Transfer(msg.sender, address(0), amount);
    }
}