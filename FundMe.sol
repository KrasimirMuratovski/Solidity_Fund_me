//Get funds from user

//Wthdraw funds

//Set a minimum funding value

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {PriceConverter} from "./PriceConverter.sol";


contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18;
    address[] public funders;
    // mapping(address => uint256); // the types can be named as below >>>
    mapping(address funder =>uint256 amountfunded) public addressToAmountFunded;


    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender; //msg.sender - deployer of the contract

    }

    function fund() public payable{        
        //msg.value act as an input parameter for getConversionRate() below
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Did not send enough ETH");//msg.value is GLOBAL VAR in Solidity
        funders.push(msg.sender); //msg.sender is another GLOBAL VAR in Solidity
        addressToAmountFunded[msg.sender]  += msg.value;
        //What is a revert?
        //Undo any actions that have been done, and send the remaining gas back.


    }


//only the owner of the contract must be able to call this function!!
    function withdraw() public onlyOwner {
        //"only owner" modifier will be executed first
        for(uint256 funderIndex = 0; funderIndex<funders.length;funderIndex++){
            address funder = funders[funderIndex];//how we take just the address from the list??
            addressToAmountFunded[funder]=0;
        }
        //reset the array
        funders = new address[](0);

        // //transfer - fails if gas overflow; auto revert
        // payable(msg.sender).transfer(address(this).balance);

        // //send - returns bool with the result - does not fail and revert
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        
        //call - low level - can call any function in ETH without ABI
        //recomended way
        (bool callSuccess, )=payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess,"Call failed");

        // msg.sender is type address
        //payable(msg.sender) = payable address - we need this type in order to send tokens

            }  

    modifier onlyOwner(){
        require(msg.sender == i_owner, "sender is not owner");
        _; // this means "require" will be executed first
    }


}

