// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Import the ERC20 interface, UniswapV2Router interface, and UniswapV2Factory interface.
import "./IERC20.sol";
import "./IUniswapV2Router.sol";
import "./IUniswapV2Factory.sol";

contract UniswapV2Liquidity {
    // Define constants for UniswapV2Router, UniswapV2Factory, WETH, and DAI addresses.
    address private constant UNISWAP_V2_ROUTER =
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address private constant UNISWAP_V2_FACTORY =
        0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;

    // Initialize instances of UniswapV2Router, UniswapV2Factory, WETH, and DAI using their interfaces.
    IUniswapV2Router private constant router =
        IUniswapV2Router(UNISWAP_V2_ROUTER);
    IUniswapV2Factory private constant factory =
        IUniswapV2Factory(UNISWAP_V2_FACTORY);
    IERC20 private constant weth = IERC20(WETH);
    IERC20 private constant dai = IERC20(DAI);

    // Create an immutable instance of the liquidity pool pair using UniswapV2Factory.
    IERC20 private immutable pair;

    constructor() {
        pair = IERC20(factory.getPair(WETH, DAI));
    }

    // Function to add liquidity to the WETH-DAI pool.
    function addLiquidity(
        uint wethAmountDesired,
        uint daiAmountDesired
    ) external {
        // Transfer WETH and DAI tokens from the caller to this contract.
        weth.transferFrom(msg.sender, address(this), wethAmountDesired);
        dai.transferFrom(msg.sender, address(this), daiAmountDesired);
        
        // Approve the UniswapV2Router to spend the transferred tokens.
        weth.approve(address(router), wethAmountDesired);
        dai.approve(address(router), daiAmountDesired);
        
        // Add liquidity to the pool using UniswapV2Router's addLiquidity function.
        (uint amountA, uint amountB, uint liquidity) = router.addLiquidity(
            WETH, DAI, wethAmountDesired, daiAmountDesired, 1, 1, 
            msg.sender, block.timestamp);
        
        // Refund any excess WETH or DAI tokens back to the caller.
        if (wethAmountDesired > amountA) {
            weth.transfer(msg.sender, wethAmountDesired - amountA);
        }
        if (daiAmountDesired > amountB) {
            dai.transfer(msg.sender, daiAmountDesired - amountB);
        }
    }

    // Function to remove liquidity from the WETH-DAI pool.
    function removeLiquidity(uint liquidity) external {
        // Transfer LP tokens from the caller to this contract.
        pair.transferFrom(msg.sender, address(this), liquidity);
        
        // Approve the UniswapV2Router to spend the transferred LP tokens.
        pair.approve(address(router), liquidity);
        
        // Remove liquidity from the pool using UniswapV2Router's removeLiquidity function.
        router.removeLiquidity(WETH, DAI, liquidity, 1, 1, 
            msg.sender, block.timestamp);
    }
}
//This Solidity contract, named `UniswapV2Liquidity`, facilitates the addition and removal of liquidity for the WETH (Wrapped Ether) and DAI trading pair on Uniswap V2. It uses the UniswapV2Router and UniswapV2Factory interfaces for interacting with the Uniswap V2 protocol. In summary, this contract allows users to add and remove liquidity to/from the WETH-DAI trading pair on Uniswap V2. The `addLiquidity` function lets users deposit a specific amount of WETH and DAI into the pool, and it refunds any excess tokens back to the caller. The `removeLiquidity` function allows users to withdraw liquidity from the pool by providing LP tokens, and it returns the corresponding amounts of WETH and DAI to the caller. This contract facilitates liquidity provision and removal for decentralized trading on the Ethereum network.