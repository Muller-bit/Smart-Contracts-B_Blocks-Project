// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

//import {AggregatorV3Interface} from "@chainlink/contracts@1.3.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import{PriceConverter}from"./PriceConverter.sol";
//constact , immutable 
//616, 568 gas 
//595302 gas  now it became less

error NotOwner();
contract FundMe{
    // it must be public function to allow anyone be able  to send fund use key word payable
   //uint256 public myValue = 1 ;

    uint256 public constant  MINIMUM_USD = 5e18; //351 gas with constant ,2451 gas non-constant 
    using PriceConverter for uint256;
    address [] public funders;//list of address that fund 
    //we are mapping to know which address sent how much
    mapping (address funder => uint256 amountFunded)  public addressToAmountFunded; 
        
    address public immutable i_owner; //global variable   - immutable

    constructor()  {
        i_owner = msg.sender;
        
    }

   function fund()public payable{
        //allow users to send $
        //have a minimum  $ 5 usd 
        //myValue = myValue + 2;
        require(msg.value.getConversionRate() >= MINIMUM_USD , "didnt send enough ETH" ); //1e18 = 1 ETH or 1 times 10*18 
        //how ever getConversionRate returns with e18 ,so change  minimumUsd value to 5 * e18
        //msg.value has 18 decimal places and its uint256 type 
        //what is revert ?
        //undo any action that have been done before and send the remaining gas back 
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value ;
        //at start sender will be zero because we can not push same address to list twice
        //add the value of  msg.value to the current amount of funds
         //amount of funds + how much they sent us
   }
   
   //lets the i_owner to withdraw the fund using this function
   // [1 , 2 , 3 , 4]  => elements   , we need to loop thiritu
   // 0  , 1  , 2  ,3  => Index
   function Withdraw ()public onlyi_owner{  // here we have modifier dont forget 
     
      for (uint256 funderIndex = 0 ; funderIndex < funders.length ; funderIndex++) 
      {
          address funder = funders[funderIndex];
          addressToAmountFunded[funder] = 0; // we set to zero after withdrawal 
      }
       funders = new address[](0); //Clearing the array of addresses called resetting
        
        //There are 3 ways to Withdraw  ETH
        // transfer
         //payable(msg.sender).transfer(address(this).balance);
         //Send  => returns boolean 
         /*bool sendSuccess = payable(msg.sender).send(address(this).balance);
         require(sendSuccess, "Send failed");*/

        // call => recommended at low level
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
     
     modifier onlyi_owner {
        //require(msg.sender == i_owner , "Sender is not  i_owner!");// checker for i_owner
         if(msg.sender != i_owner){
            revert NotOwner();
         }
        _; //this underscore means that this code will run after the require condition is done executing
     }
      
       // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \
    //         yes  no
    //         /     \
    //    receive()?  fallback()
    //     /   \
    //   yes   no
    //  /        \
    //receive()  fallback()


    receive() external payable {
        fund();
    }

      fallback() external payable {
        fund();
    }
}


   
    
  
    

    
    
    


