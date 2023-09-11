
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Import and use hardhat/console.sol to debug your contract
// import "hardhat/console.sol";

import "./IERC20.sol";
import "./ISwapRouter.sol";
import "./IUniswapV3Pool.sol";

contract UniswapV3FlashSwap {
    // Define the Uniswap V3 SwapRouter contract address
    ISwapRouter constant router =
        ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);

    // Constants for minimum and maximum square root ratio
    uint160 internal constant MIN_SQRT_RATIO = 4295128739;
    uint160 internal constant MAX_SQRT_RATIO =
        1461446703485210103287273052203988822378723970342;

    // Define the addresses for USDC and WETH tokens
    address private constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    // Create instances of the ERC20 token contracts for USDC and WETH
    IERC20 private constant usdc = IERC20(USDC);
    IERC20 private constant weth = IERC20(WETH);

    function flashSwap(address pool0, uint24 fee1, uint wethAmountIn) external {
        // Encode flash swap data into bytes
        bytes memory data = abi.encode(msg.sender, pool0, fee1);
        
        // Initiate a flash swap from the Uniswap V3 pool
        IUniswapV3Pool(pool0).swap(address(this), false, int(wethAmountIn), MAX_SQRT_RATIO - 1, data);
    }

    function _swap(
        address tokenIn,
        address tokenOut,
        uint24 fee,
        uint amountIn
    ) private returns (uint amountOut) {
        // Approve the SwapRouter to spend the input token
        IERC20(tokenIn).approve(address(router), amountIn);
        
        // Define parameters for the exact input single swap
        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams(
            tokenIn, tokenOut, fee, address(this), block.timestamp, amountIn, 0, 0);
        
        // Perform the exact input single swap using the SwapRouter
        amountOut = router.exactInputSingle(params);
    }

    function uniswapV3SwapCallback(
        int amount0,
        int amount1,
        bytes calldata data
    ) external {
        // Decode the flash swap data
        (address caller, address pool0, uint24 fee1) = abi.decode(
            data,
            (address, address, uint24)
        );
        
        // Ensure that the caller is the Uniswap V3 pool
        require(msg.sender == address(pool0), "not authorized");
        
        // Calculate the amounts received in the flash swap
        uint usdcAmountOut = uint(-amount0); // Convert negative amount0 to uint
        uint wethAmountIn = uint(amount1);
        
        // Perform a token swap to convert USDC to WETH
        uint wethAmountOut = _swap(USDC, WETH, fee1, usdcAmountOut);
        
        if (wethAmountOut >= wethAmountIn) {
            // Calculate profit if any and transfer it to the caller
            uint profit = wethAmountOut - wethAmountIn;
            weth.transfer(address(pool0), wethAmountIn); // Return borrowed WETH
            weth.transfer(caller, profit); // Transfer profit to the caller
        } else {
            // Calculate loss if any and handle it
            uint loss = wethAmountIn - wethAmountOut;
            weth.transferFrom(caller, address(this), loss); // Take loss from the caller
            weth.transfer(address(pool0), wethAmountIn); // Return borrowed WETH
        }
    }
}

/*
This Solidity contract allows users to perform flash swaps between USDC and WETH tokens using Uniswap V3. Here's how it works:

1. Users can initiate a flash swap by calling the `flashSwap` function, providing the Uniswap V3 pool address, the fee for the swap (`fee1`), and the amount of WETH they want to swap (`wethAmountIn`).

2. Inside the `flashSwap` function, flash swap data is encoded into bytes and passed to the `IUniswapV3Pool.swap` function. This initiates the flash swap from the Uniswap V3 pool.

3. After the flash swap is executed, the Uniswap V3 pool calls the `uniswapV3SwapCallback` function to handle the results of the swap.

4. In the `uniswapV3SwapCallback` function, it first decodes the flash swap data to retrieve the original caller's address, the Uniswap V3 pool address (`pool0`), and the fee for the swap (`fee1`).

5. It verifies that the caller is the Uniswap V3 pool to prevent unauthorized access.

6. It calculates the amounts received in the flash swap, converts USDC to WETH using the `_swap` function

, and handles any profit or loss accordingly.

7. If the received WETH amount (`wethAmountOut`) is greater than or equal to the provided `wethAmountIn`, it calculates and transfers the profit (if any) to the caller.

8. If the received WETH amount is less than `wethAmountIn`, it calculates and handles the loss by taking the loss from the caller.

This contract facilitates flash swaps between USDC and WETH tokens and handles the associated token conversions and profit/loss calculations.
*/