# Atomic Swap DEX Aggregator

This repository features a high-performance DEX aggregator designed to fetch the best prices across multiple Decentralized Exchanges. It ensures that trades are "atomic"—meaning they either execute fully at the desired price or revert entirely, protecting the user from partial fills or unfavorable price impact.

## System Workflow
1. **Quote Fetching:** The aggregator checks multiple pools for the target pair.
2. **Optimal Pathing:** It identifies the route with the least slippage.
3. **Atomic Execution:** The contract swaps tokens across the selected DEXs in one block.
4. **Slippage Protection:** If the final output is lower than the `minAmountOut`, the entire transaction fails.



## Core Features
* **Multi-DEX Support:** Ready for Uniswap V2/V3 and Sushiswap.
* **Security:** Integrated `ReentrancyGuard` and strict `deadline` checks.
* **Gas Efficiency:** Minimalist logic to reduce overhead during complex route execution.

## Installation
Deploy the `Aggregator.sol` contract and pass the approved router addresses to the whitelist.
