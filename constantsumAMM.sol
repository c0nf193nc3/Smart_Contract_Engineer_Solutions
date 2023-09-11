// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";

contract CSAMM {
    IERC20 public immutable token0;
    IERC20 public immutable token1;

    uint public reserve0;
    uint public reserve1;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    constructor(address _token0, address _token1) {
        // Initialize the contract with two ERC-20 token addresses
        // Assumes both tokens have the same number of decimals
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
    }

    // Private function to mint shares for a user
    function _mint(address _to, uint _amount) private {
        balanceOf[_to] += _amount;
        totalSupply += _amount;
    }

    // Private function to burn (redeem) shares from a user
    function _burn(address _from, uint _amount) private {
        balanceOf[_from] -= _amount;
        totalSupply -= _amount;
    }
    
    // Private function to update reserves
    function _update(uint _res0, uint _res1) private {
        reserve0 = _res0;
        reserve1 = _res1;
    }

    // Function to swap tokens
    function swap(
        address _tokenIn,
        uint _amountIn
    ) external returns (uint amountOut) {
        require(_tokenIn == address(token0) || _tokenIn == address(token1), "wrong token");
        
        bool isToken0 = _tokenIn == address(token0);

        (IERC20 tokenIn, IERC20 tokenOut, uint resIn, uint resOut) = isToken0
            ? (token0, token1, reserve0, reserve1)
            : (token1, token0, reserve1, reserve0);
        
        // Transfer tokens from the user to the contract
        IERC20(_tokenIn).transferFrom(msg.sender, address(this), _amountIn);
        uint amountIn = tokenIn.balanceOf(address(this)) - resIn;
        
        // Apply a 0.3% fee to the swap
        amountOut = (amountIn * 997) / 1000;
        
        (uint res0, uint res1) = isToken0
            ? (resIn + amountIn, resOut - amountOut)
            : (resOut - amountOut, resIn + amountIn);

        _update(res0, res1);
        
        // Transfer the resulting tokens to the user
        tokenOut.transfer(msg.sender, amountOut);
    }

    // Function to add liquidity to the pool
    function addLiquidity(
        uint _amount0,
        uint _amount1
    ) external returns (uint shares) {
        // Transfer tokens from the user to the contract
        token0.transferFrom(msg.sender, address(this), _amount0);
        token1.transferFrom(msg.sender, address(this), _amount1);
        
        uint bal0 = token0.balanceOf(address(this));
        uint bal1 = token1.balanceOf(address(this));
    
        uint d0 = bal0 - reserve0;
        uint d1 = bal1 - reserve1;
    
        if (totalSupply > 0) {
            shares = ((d0 + d1) * totalSupply) / (reserve0 + reserve1);
        } else {
            shares = d0 + d1;
        }
    
        require(shares > 0, "shares = 0");
        _mint(msg.sender, shares);
    
        _update(bal0, bal1);
    }

    // Function to remove liquidity from the pool
    function removeLiquidity(uint _shares) external returns (uint d0, uint d1) {
        d0 = (reserve0 * _shares) / totalSupply;
        d1 = (reserve1 * _shares) / totalSupply;
    
        _burn(msg.sender, _shares);
        _update(reserve0 - d0, reserve1 - d1);
    
        if (d0 > 0) {
            token0.transfer(msg.sender, d0);
        }
        if (d1 > 0) {
            token1.transfer(msg.sender, d1);
        }
    }
}

/*

Explanation of the code:
The "CSAMM" (Constant Sum Automated Market Maker) contract you provided is a Solidity smart contract that implements a simple Automated Market Maker (AMM) for two ERC-20 tokens. Users can swap tokens, add liquidity to the pool, and remove liquidity from the pool. This contract follows a constant sum AMM model where the product of the reserves remains constant. Below is a detailed explanation of the code:


1. The "CSAMM" contract initializes with two ERC-20 tokens: `token0` and `token1`. It assumes that both tokens have the same number of decimal places.

2. The contract keeps track of reserves (`reserve0` and `reserve1`), total supply of shares (`totalSupply`), and the balance of shares for each user (`balanceOf` mapping).

3. The `_mint` function is a private function that mints (creates) shares for a user. It increases the user's share balance and updates the total supply of shares.

4. The `_burn` function is a private function that burns (redeems) shares from a user. It decreases the user's share balance and updates the total supply of shares.

5. The `_update` function is a private function that updates the reserves (`reserve0` and `reserve1`).

6. The `swap` function allows users to swap one token for another. It calculates the amount of tokens to swap, applies a 0.3% fee, updates the reserves, and transfers the resulting tokens to the user.

7. The `addLiquidity` function allows users to add liquidity to the pool by depositing both tokens. It calculates the number of shares to mint, transfers the tokens, and updates the reserves.

8. The `removeLiquidity` function allows users to remove liquidity from the pool by burning shares. It calculates the amounts of each token to return to the user and updates the reserves.

This contract effectively implements a simple AMM model where users can swap tokens, add liquidity, and remove liquidity while ensuring that the product of the reserves remains constant. It allows users to participate in a liquidity pool and benefit from trading fees.
*/