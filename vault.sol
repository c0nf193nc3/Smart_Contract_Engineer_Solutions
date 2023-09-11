// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";

contract Vault {
    IERC20 public immutable token; // ERC-20 token contract reference
    
    uint public totalSupply; // Total supply of shares in the vault
    mapping(address => uint) public balanceOf; // Mapping of user addresses to their share balances

    constructor(address _token) {
        token = IERC20(_token); // Initialize the token contract
    }

    // Private function to mint shares for a user
    function _mint(address _to, uint _shares) private {
        balanceOf[_to] += _shares; // Increase the user's share balance
        totalSupply += _shares; // Increase the total supply of shares
    }

    // Private function to burn (redeem) shares from a user
    function _burn(address _from, uint _shares) private {
        balanceOf[_from] -= _shares; // Decrease the user's share balance
        totalSupply -= _shares; // Decrease the total supply of shares
    }

    // Function to deposit tokens into the vault
    function deposit(uint _amount) external {
        uint shares;
        if (totalSupply == 0) {
            shares = _amount; // If the vault has no shares, user's shares equal the deposit amount
        } else {
            shares = (totalSupply * _amount) / token.balanceOf(address(this));
            // Calculate the number of shares based on the deposit amount and current token balance
        }
        
        _mint(msg.sender, shares); // Mint shares for the user
        token.transferFrom(msg.sender, address(this), _amount); // Transfer tokens from the user to the vault
    }

    // Function to withdraw tokens from the vault
    function withdraw(uint _shares) external {
        uint amount = (token.balanceOf(address(this)) * _shares) / totalSupply;
        // Calculate the amount to withdraw based on the user's shares and the total supply

        _burn(msg.sender, _shares); // Burn (redeem) the user's shares
        token.transfer(msg.sender, amount); // Transfer tokens to the user
    }
}

/* 

Explanation of the code:
The "Vault" contract you provided is a Solidity smart contract that implements a simple vault for an ERC-20 token. Users can deposit and withdraw tokens, and their token balances are represented as "shares" in the vault. Here's a detailed explanation of the code:


1. The "Vault" contract is initialized with an address pointing to an ERC-20 token contract. This token is stored in the `token` state variable.

2. The contract keeps track of the total supply of shares (`totalSupply`) and the balance of shares for each user (`balanceOf` mapping).

3. The `_mint` function is a private function that mints (creates) shares for a user. It increases the user's share balance and updates the total supply of shares.

4. The `_burn` function is a private function that burns (redeems) shares from a user. It decreases the user's share balance and updates the total supply of shares.

5. The `deposit` function allows users to deposit tokens into the vault. The number of shares created for the user depends on their deposit amount and the existing total supply of shares. If the vault has no shares (i.e., it's the first deposit), the user's shares equal the deposit amount. Otherwise, shares are calculated proportionally based on the deposit amount and the current token balance of the vault.

6. The `withdraw` function allows users to withdraw tokens from the vault. It calculates the amount to withdraw based on the number of shares the user wants to redeem and the current total supply of shares. The user's shares are burned (redeemed), and tokens are transferred to the user.

This contract effectively allows users to deposit tokens, receive shares in return, and later withdraw tokens based on the number of shares they hold. It provides a simple way to manage and track token deposits and shares within the vault.
*/