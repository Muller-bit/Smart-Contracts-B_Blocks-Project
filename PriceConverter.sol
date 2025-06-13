// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {AggregatorV3Interface} from "@chainlink/contracts@1.3.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
library PriceConverter {
   

    function getPrice()internal  view returns (uint256) {
        //Address  0x694AA1769357215DE4FAC081bf1f309aDC325306 ,at this address 
        //ABI  but we want to get the price 
        //create new variable called priceFeed
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        // answer means price :) so lets deleted the rest since we need only to get price in usd
        //price of ETH in USD 
        //2000.00000000  
                ( ,int256 answer,,,) = priceFeed.latestRoundData();
                return uint256(answer)*1e10; // to add additional 10 decinal places also change the to uint256 use type casting
                // here we get answer with 18decimal places 
    }

    function getConversionRate(uint256 ethAmount )internal view returns (uint256){
         //1 ETH? 
         //2000_000000000000000000 lets say its current price 
         uint256 ethPrice = getPrice();
         //(2000_000000000000000000 )*(1_e18)/1e18
         //$2000 = 1 ETH because zeros after decimal point is useless
         //here its because when we multiply they will have 36 zeros then we divide by 1e18 to get 1e18 alone  
         uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; 
         return ethAmountInUsd; //the  value of eth in usd its simple

      //    require(getConversionRate(msg.value )>= minimumUsd , "didnt send enough ETH" ); //1e18 = 1 ETH or 1 times 10*18 

    }

    function getVersion()internal  view returns (uint256){
     return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    } 
     
     
}