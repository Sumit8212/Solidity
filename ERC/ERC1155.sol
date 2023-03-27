// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract ERC1155{

address public owner;

constructor(){
    owner=msg.sender;
}

mapping(address=>mapping(uint256 => uint256))balances;
mapping(address => mapping(address => uint256))allowed;
mapping(address => mapping(address => bool)) _operatorApprovals;


 modifier onlyOwner(){
        require(msg.sender == owner, "only owner can run this function");
        _;
    }

    function mint(address account, uint256 id, uint256 amount)public onlyOwner{
        balances[account][id]+=amount;
    }
    
    
     

}