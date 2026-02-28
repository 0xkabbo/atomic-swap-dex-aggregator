// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

interface IUniswapV2Router {
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
}

contract DexAggregator is ReentrancyGuard, Ownable {
    constructor() Ownable(msg.sender) {}

    /**
     * @dev Executes a swap across a specific DEX router.
     * @param router The address of the DEX router (e.g., Uniswap).
     * @param amountIn Amount of source tokens to swap.
     * @param amountOutMin Minimum amount of destination tokens expected.
     * @param path Array of token addresses representing the swap route.
     * @param deadline Unix timestamp after which the transaction will revert.
     */
    function executeSwap(
        address router,
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        uint256 deadline
    ) external nonReentrant returns (uint256[] memory amounts) {
        require(path.length >= 2, "Invalid path");
        
        // Transfer tokens from user to this contract
        IERC20(path[0]).transferFrom(msg.sender, address(this), amountIn);
        
        // Approve router to spend tokens
        IERC20(path[0]).approve(router, amountIn);

        // Execute the swap
        amounts = IUniswapV2Router(router).swapExactTokensForTokens(
            amountIn,
            amountOutMin,
            path,
            msg.sender, // Tokens sent directly to user
            deadline
        );
    }

    /**
     * @dev Emergency withdraw for stuck tokens.
     */
    function recoverTokens(address token) external onlyOwner {
        uint256 balance = IERC20(token).balanceOf(address(this));
        IERC20(token).transfer(msg.sender, balance);
    }
}
