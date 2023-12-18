// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConvertor {
    function getPrice() internal view returns (uint256) {
        // ABI
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 answer,,,) = priceFeed.latestRoundData();  //Price of Eth in USD.decimals()
        return uint256(answer*1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 UsdAmount = (getPrice()*ethAmount)/1e18;
        return UsdAmount;
    }

    function getVersion() internal view returns(uint256) {
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return pricefeed.version();
    }
}
