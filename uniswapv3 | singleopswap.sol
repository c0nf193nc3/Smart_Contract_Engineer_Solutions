// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Import and use hardhat/console.sol to debug your contract
// import "hardhat/console.sol";

import "./IERC20.sol";
import "./ISwapRouter.sol";

contract UniswapV3SingleHopSwap {
    // Define a constant for the Uniswap V3 SwapRouter contract address
    ISwapRouter private constant router =
        ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);

    // Define constants for the WETH (Wrapped Ether) and DAI token addresses
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    // Create instances of the ERC20 token contracts for WETH and DAI
    IERC20 private constant weth = IERC20(WETH);
    IERC20 private constant dai = IERC20(DAI);

    // Function for swapping an exact amount of WETH for DAI
    function swapExactInputSingleHop(
        uint amountIn,    // Amount of WETH to swap
        uint amountOutMin // Minimum amount of DAI expected to receive
    ) external {
        // Transfer the specified amount of WETH from the caller to this contract
        weth.transferFrom(msg.sender, address(this), amountIn);
        // Approve the SwapRouter contract to spend the transferred WETH
        weth.approve(address(router), amountIn);

        // Create parameters for the ExactInputSingle swap
        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams(
            WETH,          // Token to swap from (WETH)
            DAI,           // Token to swap to (DAI)
            3000,          // Fee in basis points (0.3% fee)
            msg.sender,    // Recipient of DAI tokens
            block.timestamp,// Deadline for the swap
            amountIn,      // Amount of WETH to swap
            amountOutMin,  // Minimum amount of DAI expected
            0              // Flags (not used)
        );

        // Perform the ExactInputSingle swap using the SwapRouter
        router.exactInputSingle(params);
    }

    // Function for swapping a specified amount of DAI for as much WETH as possible
    function swapExactOutputSingleHop(
        uint amountOut,   // Amount of DAI to receive
        uint amountInMax  // Maximum amount of WETH to spend
    ) external {
        // Transfer the specified maximum amount of WETH from the caller to this contract
        weth.transferFrom(msg.sender, address(this), amountInMax);
        // Approve the SwapRouter contract to spend the transferred WETH
        weth.approve(address(router), amountInMax);

        // Create parameters for the ExactOutputSingle swap
        ISwapRouter.ExactOutputSingleParams memory params = ISwapRouter.ExactOutputSingleParams(
            WETH,          // Token to swap from (WETH)
            DAI,           // Token to swap to (DAI)
            3000,          // Fee in basis points (0.3% fee)
            msg.sender,    // Recipient of DAI tokens
            block.timestamp,// Deadline for the swap
            amountOut,     // Amount of DAI to receive
            amountInMax,   // Maximum amount of WETH to spend
            0              // Flags (not used)
        );

        // Perform the ExactOutputSingle swap using the SwapRouter
        uint amountIn = router.exactOutputSingle(params);

        // If the actual amount of WETH spent is less than the maximum specified,
        // refund the remaining WETH to the caller
        if (amountInMax > amountIn) {
            weth.approve(address(router), 0); // Clear approval
            weth.transfer(msg.sender, amountInMax - amountIn);
        }
    }
}

/*
This Solidity contract allows users to perform single-hop swaps between WETH and DAI tokens using the Uniswap V3 SwapRouter. It provides two main functions:

1. `swapExactInputSingleHop`: Allows users to swap an exact amount of WETH for DAI. The user specifies the amount of WETH to swap and the minimum amount of DAI expected to receive.

2. `swapExactOutputSingleHop`: Allows users to swap a specified amount of DAI for as much WETH as possible. The user specifies the amount of DAI to receive and the maximum amount of WETH to spend.

Both functions involve transferring WETH from the caller to the contract, approving the SwapRouter to spend WETH, and then performing the swap with the specified parameters. If the actual amount of WETH spent in the `swapExactOutputSingleHop` function is less than the maximum specified, the remaining WETH is refunded to the caller.

Please note that this contract assumes that the SwapRouter and token addresses are correct and that the caller has already approved the contract to spend their WETH tokens.
*/