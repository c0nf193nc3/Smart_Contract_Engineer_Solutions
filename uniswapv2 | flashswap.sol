
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Import necessary interfaces.
import "./IERC20.sol";
import "./IUniswapV2Factory.sol";
import "./IUniswapV2Callee.sol";
import "./IUniswapV2Pair.sol";

contract UniswapV2FlashSwap is IUniswapV2Callee {
    // Define constant addresses for Uniswap V2 Factory, DAI, and WETH.
    address private constant UNISWAP_V2_FACTORY =
        0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    address private constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    // Initialize Uniswap V2 Factory and WETH instances.
    IUniswapV2Factory private constant factory =
        IUniswapV2Factory(UNISWAP_V2_FACTORY);
    IERC20 private constant weth = IERC20(WETH);

    // Create an immutable instance of the DAI-WETH pair using Uniswap V2 Factory.
    IUniswapV2Pair private immutable pair;

    constructor() {
        pair = IUniswapV2Pair(factory.getPair(DAI, WETH));
    }

    // Function to initiate a flash swap of WETH.
    function flashSwap(uint wethAmount) external {
        // Encode data for the callback function.
        bytes memory data = abi.encode(WETH, msg.sender);
        // Initiate the flash swap by calling the swap function of the pair contract.
        pair.swap(0, wethAmount, address(this), data);
    }

    // This function is called by the DAI-WETH pair contract as part of the flash swap.
    function uniswapV2Call(
        address sender,
        uint amount0,
        uint amount1,
        bytes calldata data
    ) external {
        // Ensure that the caller is the pair contract.
        require(msg.sender == address(pair), "pair contract only");
        // Ensure that the initiator is this contract.
        require(sender == address(this), "wrong initiator");
        // Decode the data received from the flash swap.
        (address tokenBorrow, address caller) = abi.decode(data, (address, address));
        
        // Custom code for flash swap arbitrage can be implemented here.
        // In this example, it checks if the borrowed token is WETH.
        require(tokenBorrow == WETH, "token borrow != WETH");
        
        // Calculate the flash swap fee (0.3% fee, rounded up).
        uint fee = ((amount1 * 3) / 997) + 1;
        // Calculate the total amount to be repaid, including the fee.
        uint amountToRepay = amount1 + fee;
        
        // Transfer the flash swap fee from the caller to this contract.
        weth.transferFrom(caller, address(this), fee);
        
        // Repay the flash loan by transferring WETH back to the pair contract.
        weth.transfer(address(pair), amountToRepay);
    }
}


// This Solidity contract, named `UniswapV2FlashSwap`, enables flash swaps between DAI (or another token) and WETH (Wrapped Ether) on the Uniswap V2 decentralized exchange. Flash swaps allow users to borrow tokens without providing collateral as long as they repay the borrowed amount within the same transaction. In summary, this contract allows users to perform flash swaps, borrowing WETH from the DAI-WETH pair on Uniswap V2 without collateral. The `flashSwap` function initiates a flash swap, and the `uniswapV2Call` function is called by the pair contract as part of the flash swap process. It allows users to arbitrage, manipulate token prices, or perform other actions within the same transaction, as long as they repay the borrowed amount plus a fee.