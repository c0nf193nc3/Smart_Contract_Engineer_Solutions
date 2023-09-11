// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Import the ERC20 interface and the UniswapV2Router interface.
import "./IERC20.sol";
import "./IUniswapV2Router.sol";

contract UniswapV2MultiHopSwap {
    // Define constants for UniswapV2Router, WETH, DAI, and CRV addresses.
    address private constant UNISWAP_V2_ROUTER =
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant CRV = 0xD533a949740bb3306d119CC777fa900bA034cd52;

    // Initialize instances of UniswapV2Router, WETH, DAI, and CRV using their interfaces.
    IUniswapV2Router private constant router =
        IUniswapV2Router(UNISWAP_V2_ROUTER);
    IERC20 private constant weth = IERC20(WETH);
    IERC20 private constant dai = IERC20(DAI);
    IERC20 private constant crv = IERC20(CRV);

    // Function to swap a specific amount of DAI for CRV through a multi-hop path.
    function swapMultiHopExactAmountIn(
        uint amountIn,
        uint amountOutMin
    ) external {
        // Transfer DAI tokens from the caller to this contract.
        dai.transferFrom(msg.sender, address(this), amountIn);
        // Approve the UniswapV2Router to spend the transferred DAI tokens.
        dai.approve(address(router), amountIn);
        
        // Create a path array for the token swap, consisting of DAI, WETH, and CRV.
        address[] memory path = new address[](3);
        path[0] = DAI;
        path[1] = WETH;
        path[2] = CRV;
        
        // Execute the token swap using UniswapV2Router's swapExactTokensForTokens function.
        router.swapExactTokensForTokens(
            amountIn,
            amountOutMin,
            path,
            msg.sender, // Send the CRV tokens to the caller.
            block.timestamp
        );
    }

    // Function to swap for a specific amount of CRV by providing a maximum amount of DAI.
    function swapMultiHopExactAmountOut(
        uint amountOutDesired,
        uint amountInMax
    ) external {
        // Transfer DAI tokens from the caller to this contract.
        dai.transferFrom(msg.sender, address(this), amountInMax);
        // Approve the UniswapV2Router to spend the transferred DAI tokens.
        dai.approve(address(router), amountInMax);
        
        // Create a path array for the token swap, consisting of DAI, WETH, and CRV.
        address[] memory path = new address[](3);
        path[0] = DAI;
        path[1] = WETH;
        path[2] = CRV;
        
        // Execute the token swap using UniswapV2Router's swapTokensForExactTokens function.
        uint[] memory amounts = router.swapTokensForExactTokens(
            amountOutDesired,
            amountInMax,
            path,
            msg.sender, // Send the CRV tokens to the caller.
            block.timestamp
        );
        
        // If the actual input amount exceeds the maximum allowed, refund the excess DAI tokens.
        if (amountInMax > amounts[0]) {
            dai.transfer(msg.sender, amountInMax - amounts[0]);
        }
    }
}
// This Solidity contract, named `UniswapV2MultiHopSwap`, facilitates multi-hop token swaps between DAI, WETH (Wrapped Ether), and CRV on the Uniswap V2 decentralized exchange using the UniswapV2Router interface. The contract provides two functions for swapping tokens: `swapMultiHopExactAmountIn` and `swapMultiHopExactAmountOut`. In summary, this contract allows users to perform multi-hop token swaps between DAI, WETH, and CRV on Uniswap V2. The `swapMultiHopExactAmountIn` function swaps a specific amount of DAI for CRV, ensuring that the received amount of CRV is greater than or equal to `amountOutMin`. The `swapMultiHopExactAmountOut` function swaps for a specific amount of CRV by providing a maximum amount of DAI. Any excess DAI tokens are refunded to the caller. This contract can be used for decentralized trading of these tokens on the Ethereum network.
