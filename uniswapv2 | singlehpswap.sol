// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Import the ERC20 interface and the UniswapV2Router interface.
import "./IERC20.sol";
import "./IUniswapV2Router.sol";

contract UniswapV2SingleHopSwap {
    // Define constants for UniswapV2Router, WETH, and DAI addresses.
    address private constant UNISWAP_V2_ROUTER =
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    // Initialize instances of UniswapV2Router, WETH, and DAI using their interfaces.
    IUniswapV2Router private constant router =
        IUniswapV2Router(UNISWAP_V2_ROUTER);
    IERC20 private constant weth = IERC20(WETH);
    IERC20 private constant dai = IERC20(DAI);

    // Function to swap a specific amount of WETH for DAI.
    function swapSingleHopExactAmountIn(
        uint amountIn,
        uint amountOutMin
    ) external {
        // Transfer WETH tokens from the caller to this contract.
        weth.transferFrom(msg.sender, address(this), amountIn);
        // Approve the UniswapV2Router to spend the transferred WETH tokens.
        weth.approve(address(router), amountIn);
        
        // Create a path array for the token swap, starting with WETH and ending with DAI.
        address[] memory path = new address[](2);
        path[0] = WETH;
        path[1] = DAI;
        
        // Execute the token swap using UniswapV2Router's swapExactTokensForTokens function.
        router.swapExactTokensForTokens(
            amountIn,
            amountOutMin,
            path,
            msg.sender, // Send the DAI tokens to the caller.
            block.timestamp
        );
    }

    // Function to swap a specific amount of WETH for a desired amount of DAI.
    function swapSingleHopExactAmountOut(
        uint amountOutDesired,
        uint amountInMax
    ) external {
        // Transfer WETH tokens from the caller to this contract.
        weth.transferFrom(msg.sender, address(this), amountInMax);
        // Approve the UniswapV2Router to spend the transferred WETH tokens.
        weth.approve(address(router), amountInMax);
        
        // Create a path array for the token swap, starting with WETH and ending with DAI.
        address[] memory path = new address[](2);
        path[0] = WETH;
        path[1] = DAI;
        
        // Execute the token swap using UniswapV2Router's swapTokensForExactTokens function.
        uint[] memory amounts = router.swapTokensForExactTokens(
            amountOutDesired,
            amountInMax,
            path,
            msg.sender, // Send the DAI tokens to the caller.
            block.timestamp
        );
        
        // If the actual input amount exceeds the maximum allowed, refund the excess WETH tokens.
        if (amountInMax > amounts[0]) {
            weth.transfer(msg.sender, amountInMax - amounts[0]);
        }
    }
}


// This Solidity contract, named `UniswapV2SingleHopSwap`, facilitates single-hop token swaps between WETH (Wrapped Ether) and DAI on the Uniswap V2 decentralized exchange using the UniswapV2Router interface. The contract provides two functions for swapping tokens: `swapSingleHopExactAmountIn` and `swapSingleHopExactAmountOut`. In summary, this contract allows users to perform single-hop token swaps between WETH and DAI on Uniswap V2. The `swapSingleHopExactAmountIn` function swaps a specific amount of WETH for DAI, ensuring that the received amount of DAI is greater than or equal to `amountOutMin`. The `swapSingleHopExactAmountOut` function swaps WETH for a desired amount of DAI, with a maximum allowed input of `amountInMax`. Any excess WETH tokens are refunded to the caller. This contract can be used for decentralized trading of these tokens on the Ethereum network.
