
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Import and use hardhat/console.sol to debug your contract
// import "hardhat/console.sol";

import "./IERC20.sol";
import "./ISwapRouter.sol";

contract UniswapV3MultiHopSwap {
    // Define a constant for the Uniswap V3 SwapRouter contract address
    ISwapRouter private constant router =
        ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);

    // Define constants for the WETH (Wrapped Ether), USDC, and DAI token addresses
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address private constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    // Create instances of the ERC20 token contracts for WETH and DAI
    IERC20 private constant weth = IERC20(WETH);
    IERC20 private constant dai = IERC20(DAI);

    // Function for swapping an exact amount of WETH through multiple hops to DAI
    function swapExactInputMultiHop(uint amountIn, uint amountOutMin) external {
        // Transfer the specified amount of WETH from the caller to this contract
        weth.transferFrom(msg.sender, address(this), amountIn);
        // Approve the SwapRouter contract to spend the transferred WETH
        weth.approve(address(router), amountIn);

        // Define the token path for the multi-hop swap
        bytes memory path = abi.encodePacked(
            WETH,         // Start with WETH
            uint24(3000), // Swap from WETH to USDC (3000 represents the fee)
            USDC,         // Swap from USDC to DAI
            uint24(100),  // Swap from USDC to DAI (100 represents the fee)
            DAI           // End with DAI
        );

        // Create parameters for the ExactInput swap
        ISwapRouter.ExactInputParams memory params = ISwapRouter.ExactInputParams(
            path,         // Token path
            msg.sender,   // Recipient of DAI tokens
            block.timestamp, // Deadline for the swap
            amountIn,     // Amount of WETH to swap
            amountOutMin  // Minimum amount of DAI expected
        );

        // Perform the ExactInput multi-hop swap using the SwapRouter
        router.exactInput(params);
    }

    // Function for swapping for a specified amount of DAI through multiple hops
    function swapExactOutputMultiHop(
        uint amountOut,   // Amount of DAI to receive
        uint amountInMax  // Maximum amount of WETH to spend
    ) external {
        // Transfer the specified maximum amount of WETH from the caller to this contract
        weth.transferFrom(msg.sender, address(this), amountInMax);
        // Approve the SwapRouter contract to spend the transferred WETH
        weth.approve(address(router), amountInMax);

        // Define the token path for the multi-hop swap
        bytes memory path = abi.encodePacked(
            DAI,          // Start with DAI
            uint24(100),  // Swap from DAI to USDC (100 represents the fee)
            USDC,         // Swap from USDC to WETH
            uint24(3000), // Swap from USDC to WETH (3000 represents the fee)
            WETH          // End with WETH
        );

        // Create parameters for the ExactOutput swap
        ISwapRouter.ExactOutputParams memory params = ISwapRouter.ExactOutputParams(
            path,         // Token path
            msg.sender,   // Recipient of DAI tokens
            block.timestamp, // Deadline for the swap
            amountOut,    // Amount of DAI to receive
            amountInMax   // Maximum amount of WETH to spend
        );

        // Perform the ExactOutput multi-hop swap using the SwapRouter
        uint amountIn = router.exactOutput(params);

        // If the actual amount of WETH spent is less than the maximum specified,
        // refund the remaining WETH to the caller
        if (amountInMax > amountIn) {
            weth.approve(address(router), 0); // Clear approval
            weth.transfer(msg.sender, amountInMax - amountIn);
        }
    }
}

/*
This Solidity contract allows users to perform multi-hop swaps between WETH, USDC, and DAI tokens using the Uniswap V3 SwapRouter. It provides two main functions:

1. `swapExactInputMultiHop`: Allows users to swap an exact amount of WETH for DAI through multiple hops. The user specifies the amount of WETH to swap and the minimum amount of DAI expected to receive.

2. `swapExactOutputMultiHop`: Allows users to swap for a specified amount of DAI through multiple hops using WETH as an intermediary. The user specifies the amount of DAI to receive and the maximum amount of WETH to spend.

Both functions involve transferring WETH from the caller to the contract, approving the SwapRouter to spend WETH, defining the token path for the multi-hop swap, and then performing the swap with the specified parameters. If the actual amount of WETH spent in the `swapExactOutputMultiHop` function is less than the maximum specified, the remaining WETH is refunded to the caller.

Please note that this contract assumes that the SwapRouter and token addresses are correct, and that the caller has already approved the contract to spend their WETH tokens.

*/