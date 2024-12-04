//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FallbackExample{
    uint256 public result;

// special function - whenver send ETH or make a transaction to this contract as long as there is no data associated
//with the transaction receive() is triggered
    receive() external payable{
        result = 1;
    }

// similar to receive, but when we have calldata
    fallback() external payable{
        result = 2;
    }
}