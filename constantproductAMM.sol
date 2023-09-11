// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";

contract CPAMM {
    // Declare two ERC20 tokens and their reserves
    IERC20 public immutable token0;
    IERC20 public immutable token1;
    uint public reserve0;
    uint public reserve1;

    // Total supply of shares and user balances
    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    // Constructor initializes the contract with two ERC20 token addresses
    constructor(address _token0, address _token1) {
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
    }

    // Internal function to mint shares to an address
    function _mint(address _to, uint _amount) private {
        totalSupply += _amount;
        balanceOf[_to] += _amount;
    }

    // Internal function to burn shares from an address
    function _burn(address _from, uint _amount) private {
        totalSupply -= _amount;
        balanceOf[_from] -= _amount;
    }
    
    // Internal function to update reserves
    function _update(uint _reserve0, uint _reserve1) private {
        reserve0 = _reserve0;
        reserve1 = _reserve1;
    }

    // Swap function to exchange one token for another
    function swap(
        address _tokenIn,
        uint _amountIn
    ) external returns (uint amountOut) {
        // Ensure the input token is one of the two supported tokens
        require(
            _tokenIn == address(token0) || _tokenIn == address(token1),
            "invalid token"
        );
        require(_amountIn > 0, "amount in = 0");
        
        // Determine which token is being swapped and calculate the output amount
        bool isToken0 = _tokenIn == address(token0);
        (
            IERC20 tokenIn,
            IERC20 tokenOut,
            uint reserveIn,
            uint reserveOut
        ) = isToken0
                ? (token0, token1, reserve0, reserve1)
                : (token1, token0, reserve1, reserve0);
                
        // Transfer tokens from the user to the contract
        tokenIn.transferFrom(msg.sender, address(this), _amountIn);
        
        // Apply a 0.3% fee and calculate the output amount
        uint amountInWithFee = (_amountIn * 997) / 1000;
        amountOut = (reserveOut * amountInWithFee) / (reserveIn + amountInWithFee);

        // Transfer the output tokens to the user
        tokenOut.transfer(msg.sender, amountOut);

        // Update reserves
        _update(token0.balanceOf(address(this)), token1.balanceOf(address(this)));
    }

    // Add liquidity function to deposit tokens and receive shares
    function addLiquidity(
        uint _amount0,
        uint _amount1
    ) external returns (uint shares) {
        
        /*
        How many dx, dy to add?

        xy = k
        (x + dx)(y + dy) = k'

        No price change, before and after adding liquidity
        x / y = (x + dx) / (y + dy)

        x(y + dy) = y(x + dx)
        x * dy = y * dx

        x / y = dx / dy
        dy = y / x * dx
        */
        /*
        How many shares to mint?

        f(x, y) = value of liquidity
        We will define f(x, y) = sqrt(xy)

        L0 = f(x, y)
        L1 = f(x + dx, y + dy)
        T = total shares
        s = shares to mint

        Total shares should increase proportional to increase in liquidity
        L1 / L0 = (T + s) / T

        L1 * T = L0 * (T + s)

        (L1 - L0) * T / L0 = s 
        */
        /*
        Claim
        (L1 - L0) / L0 = dx / x = dy / y

        Proof
        --- Equation 1 ---
        (L1 - L0) / L0 = (sqrt((x + dx)(y + dy)) - sqrt(xy)) / sqrt(xy)
        
        dx / dy = x / y so replace dy = dx * y / x

        --- Equation 2 ---
        Equation 1 = (sqrt(xy + 2ydx + dx^2 * y / x) - sqrt(xy)) / sqrt(xy)

        Multiply by sqrt(x) / sqrt(x)
        Equation 2 = (sqrt(x^2y + 2xydx + dx^2 * y) - sqrt(x^2y)) / sqrt(x^2y)
                   = (sqrt(y)(sqrt(x^2 + 2xdx + dx^2) - sqrt(x^2)) / (sqrt(y)sqrt(x^2))
        
        sqrt(y) on top and bottom cancels out

        --- Equation 3 ---
        Equation 2 = (sqrt(x^2 + 2xdx + dx^2) - sqrt(x^2)) / (sqrt(x^2)
        = (sqrt((x + dx)^2) - sqrt(x^2)) / sqrt(x^2)  
        = ((x + dx) - x) / x
        = dx / x

        Since dx / dy = x / y,
        dx / x = dy / y

        Finally
        (L1 - L0) / L0 = dx / x = dy / y
        */
        // Ensure that the provided tokens will maintain the constant product
        if (reserve0 > 0 || reserve1 > 0) {
            require(reserve0 * _amount1 == reserve1 * _amount0, "incorrect amounts");
        }
        
        // Calculate the number of shares to mint
        if (totalSupply == 0) {
            shares = _sqrt(_amount0 * _amount1);
        } else {
            shares = _min(
                (_amount0 * totalSupply) / reserve0,
                (_amount1 * totalSupply) / reserve1
            );
        }
        require(shares > 0, "invalid share");
        
        // Transfer tokens from the user to the contract
        token0.transferFrom(msg.sender, address(this), _amount0);
        token1.transferFrom(msg.sender, address(this), _amount1);
        
        // Mint shares and update reserves
        _mint(msg.sender, shares);
        _update(token0.balanceOf(address(this)), token1.balanceOf(address(this)));
    }

    // Remove liquidity function to withdraw tokens and burn shares
    function removeLiquidity(
        uint _shares
    ) external returns (uint amount0, uint amount1) {

 /*
        How many tokens to withdraw?

        Claim
        dx, dy = amount of liquidity to remove
        dx = s / T * x
        dy = s / T * y

        Proof
        Let's find dx, dy such that
        v / L = s / T
        
        where
        v = f(dx, dy) = sqrt(dxdy)
        L = total liquidity = sqrt(xy)
        s = shares
        T = total supply

        --- Equation 1 ---
        v = s / T * L
        sqrt(dxdy) = s / T * sqrt(xy)

        Amount of liquidity to remove must not change price so 
        dx / dy = x / y

        replace dy = dx * y / x
        sqrt(dxdy) = sqrt(dx * dx * y / x) = dx * sqrt(y / x)

        Divide both sides of Equation 1 with sqrt(y / x)
        dx = s / T * sqrt(xy) / sqrt(y / x)
           = s / T * sqrt(x^2) = s / T * x

        Likewise
        dy = s / T * y
        */

        // Calculate the amount of tokens to withdraw based on the number of shares
        uint bal0 = token0.balanceOf(address(this));
        uint bal1 = token1.balanceOf(address(this));
    
        amount0 = (_shares * bal0) / totalSupply;
        amount1 = (_shares * bal1) / totalSupply;
        require(amount0 > 0 && amount1 > 0, "amount0 = 0 || amount1 = 0");
        
        // Burn shares and update reserves
        _burn(msg.sender, _shares);
        _update(bal0 - amount0, bal1 - amount1);

        // Transfer the withdrawn tokens to the user
        token0.transfer(msg.sender, amount0);
        token1.transfer(msg.sender, amount1);
    }

    // Internal function to calculate the square root of a number
    function _sqrt(uint y) private pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }

    // Internal function to return the minimum of two numbers
    function _min(uint x, uint y) private pure returns (uint) {
        return x <= y ? x : y;
    }
}

/*
Certainly! Let's break down the provided Solidity code step by step:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";

contract CPAMM {
    // Declare two ERC20 tokens and their reserves
    IERC20 public immutable token0;
    IERC20 public immutable token1;
    uint public reserve0;
    uint public reserve1;

    // Total supply of shares and user balances
    uint public totalSupply;
    mapping(address => uint) public balanceOf;

    // Constructor initializes the contract with two ERC20 token addresses
    constructor(address _token0, address _token1) {
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
    }
```

1. The contract begins with SPDX license information and specifies the Solidity version.

2. It imports an interface `IERC20.sol`, which likely represents the ERC-20 token standard.

3. The `CPAMM` contract is defined with state variables, including two immutable ERC20 tokens (`token0` and `token1`) and their respective reserves (`reserve0` and `reserve1`). These reserves represent the balances of the tokens in the contract.

4. It also defines the total supply of shares (`totalSupply`) and maintains a mapping (`balanceOf`) to keep track of the balance of shares for each user.

5. The constructor takes two ERC20 token addresses as parameters and initializes the `token0` and `token1` state variables.

```solidity
    // Internal function to mint shares to an address
    function _mint(address _to, uint _amount) private {
        totalSupply += _amount;
        balanceOf[_to] += _amount;
    }
```

6. `_mint` is an internal function used to mint (create) shares for a given address. It increases the total supply of shares and updates the balance of the specified address.

```solidity
    // Internal function to burn shares from an address
    function _burn(address _from, uint _amount) private {
        totalSupply -= _amount;
        balanceOf[_from] -= _amount;
    }
```

7. `_burn` is an internal function used to burn (destroy) shares from a given address. It decreases the total supply of shares and updates the balance of the specified address.

```solidity
    // Internal function to update reserves
    function _update(uint _reserve0, uint _reserve1) private {
        reserve0 = _reserve0;
        reserve1 = _reserve1;
    }
```

8. `_update` is an internal function used to update the reserve balances for `token0` and `token1` within the contract.

```solidity
    // Swap function to exchange one token for another
    function swap(
        address _tokenIn,
        uint _amountIn
    ) external returns (uint amountOut) {
        // Ensure the input token is one of the two supported tokens
        require(
            _tokenIn == address(token0) || _tokenIn == address(token1),
            "invalid token"
        );
        require(_amountIn > 0, "amount in = 0");
```

9. The `swap` function allows users to exchange one token for another within the contract. It takes an input token address (`_tokenIn`) and the amount of the input token (`_amountIn`) to swap.

10. The function checks that the input token is one of the two supported tokens (either `token0` or `token1`) and that the input amount is greater than zero.

```solidity
        // Determine which token is being swapped and calculate the output amount
        bool isToken0 = _tokenIn == address(token0);
        (
            IERC20 tokenIn,
            IERC20 tokenOut,
            uint reserveIn,
            uint reserveOut
        ) = isToken0
                ? (token0, token1, reserve0, reserve1)
                : (token1, token0, reserve1, reserve0);
```

11. The function determines which token is being swapped (`tokenIn`) and which token is being received (`tokenOut`) based on whether `_tokenIn` matches `token0` or `token1`.

12. It also determines the reserves (`reserveIn` and `reserveOut`) for the two tokens based on the swap direction.

```solidity
        // Transfer tokens from the user to the contract
        tokenIn.transferFrom(msg.sender, address(this), _amountIn);
```

13. The input token is transferred from the user's address (`msg.sender`) to the contract.

```solidity
        // Apply a 0.3% fee and calculate the output amount
        uint amountInWithFee = (_amountIn * 997) / 1000;
        amountOut = (reserveOut * amountInWithFee) / (reserveIn + amountInWithFee);
```

14. A 0.3% fee is applied to the input amount (`_amountIn`) by reducing it to 99.7% of its original value. Then, the output amount (`amountOut`) is calculated based on the reserve balances and the adjusted input amount.

```solidity
        // Transfer the output tokens to the user
        tokenOut.transfer(msg.sender, amountOut);
```

15. The output tokens are transferred from the contract to the user.

```solidity
        // Update reserves
        _update(token0.balanceOf(address(this)), token1.balanceOf(address(this)));
    }
```

16. The function concludes by updating the reserve balances within the contract based on the current balances of `token0` and `token1`.

This is the explanation for the first part of the contract. If you would like to continue with the explanation of the remaining functions, please let me know.
*/