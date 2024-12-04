//Get funds from user

//Wthdraw funds

//Set a minimum funding value

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {PriceConverter} from "./PriceConverter.sol";


contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 5e18;
    address[] public funders;
    // mapping(address => uint256); // the types can be named as below >>>
    mapping(address funder =>uint256 amountfunded) public addressToAmountFunded;

    function fund() public payable{        
        //msg.value act as an input parameter for getConversionRate() below
        require(msg.value.getConversionRate() >= minimumUsd, "Did not send enough ETH");//msg.value is GLOBAL VAR in Solidity
        funders.push(msg.sender); //msg.sender is another GLOBAL VAR in Solidity
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        //What is a revert?
        //Undo any actions that have been done, and send the remaining gas back.


    }

    function withdraw() public{
            }  


}

