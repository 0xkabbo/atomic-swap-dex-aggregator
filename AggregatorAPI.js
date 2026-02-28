// Simple helper to interact with the Aggregator contract
const ethers = require("ethers");

async function getBestRoute(tokenIn, tokenOut, amountIn) {
    // In a real scenario, this would query Uniswap and Sushiswap SDKs
    // and return the router address with the highest output.
    console.log(`Calculating best route for ${amountIn} tokens...`);
    return {
        router: "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D", // Uniswap V2
        path: [tokenIn, tokenOut],
        expectedOutput: "95.5"
    };
}

module.exports = { getBestRoute };
