//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConverter{
    function getPrice() internal view returns(uint256){
        // address 0x31D04174D0e1643963b38d87f26b0675Bb7dC96e
        //ABI
        // We have the above 2 by compiling "AggregatorV3Interface"
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x31D04174D0e1643963b38d87f26b0675Bb7dC96e);
        (, int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price) * 1e10;
    }


    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd =  (ethPrice * ethAmount)  /1e18;//!!! ALWAYS MULTIPLY BEFORE DIVIDE
        return ethAmountInUsd;
    }


    function getVersion() internal view returns (uint256) {
       return AggregatorV3Interface(0x31D04174D0e1643963b38d87f26b0675Bb7dC96e).version();
    }  
}


