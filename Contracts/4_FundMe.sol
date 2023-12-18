// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "contracts/PriceConvertor.sol";

error NotOwner();

// Gas Saving Methods:
// 1. Constant and Immutable Keywords
// 2. Using Error Function Revert instead of Require

contract FundMe {
    using PriceConvertor for uint256;

    uint256 public constant MINIMUM_USD = 50 * 10 ** 18;

    address[] public funders;
    mapping (address => uint256) public address2Eth;

    address public immutable i_owner;

    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {

        // require(msg.value >= MINIMUM_USD, "Didn't Send Enough!");
        // require(getConversionRate(msg.value) >= MINIMUM_USD, "Didn't Send Enough!");
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't Send Enough!");
        address2Eth[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function Withdraw() public onlyOwner{

        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address2Eth[funders[funderIndex]] = 0;
        }
        // resetting Array:
        funders = new address[](0);
        // Withdraw cash: (3 types)
        // 01**transfer
        // payable (msg.sender).transfer(address(this).balance);
        // 02**send
        // bool sendSuccess = payable (msg.sender).send(address(this).balance);
        // require(sendSuccess, "Transaction Failed");
        // 03**call
        (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Transaction Failed");
    }

    modifier onlyOwner {
        // require(msg.sender == i_owner, "You are not allowed to initiate this Transaction");
        if (msg.sender != i_owner) { revert NotOwner();}
        _;
    }

    receive() external payable { 
        fund();
    }

    fallback() external payable { 
        fund();
    }
}
