pragma solidity ^0.4.24;

import "./v0.4/ChainlinkClient.sol";

contract APIConsumer is ChainlinkClient {

    uint256 public ethereumPrice;

    address private oracle;
    bytes32 private jobId;
    uint256 private fee;

    /**
     * Network: Rinkeby
     * Oracle: Chainlink - 0x7AFe1118Ea78C1eae84ca8feE5C65Bc76CcF879e
     * Job ID: Chainlink - 6d1bfe27e7034b1d87b5270556b17277
     * Fee: 0.1 LINK
     */
    constructor() public {
        setPublicChainlinkToken();
        oracle = 0x7AFe1118Ea78C1eae84ca8feE5C65Bc76CcF879e;
        jobId = "6d1bfe27e7034b1d87b5270556b17277";
        fee = 0.1 * 10 ** 18; // 0.1 LINK
    }

    /**
     * Create a Chainlink request to retrieve API response, find the target price
     * data, then multiply by 100 (to remove decimal places from price).
     */
    function requestEthereumPrice() public returns (bytes32 requestId)
    {
        Chainlink.Request memory request = buildChainlinkRequest(jobId, address(this), this.fulfill.selector);

        // Set the URL to perform the GET request on
        request.add("get", "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD");

        // Set the path to find the desired data in the API response, where the response format is:
        // {"USD":243.33}
        request.add("path", "USD");

        // Multiply the result by 100 to remove decimals
        request.addInt("times", 100);

        // Sends the request
        return sendChainlinkRequestTo(oracle, request, fee);
    }

    /**
     * Receive the response in the form of uint256
     */
    function fulfill(bytes32 _requestId, uint256 _price) public recordChainlinkFulfillment(_requestId)
    {
        ethereumPrice = _price;
    }
}