// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract SumoNft{

    string public name;
    string public  symbol;
    // uint256 totalSupply;
    address public owner;
event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

mapping(address => uint256)balances;
mapping(uint256 =>address)_owners;
mapping(uint256 => address) private _tokenApprovals;
    constructor(){
        name="Sumo_NFT";
        symbol="SNT";
        owner=msg.sender;
    }

function balanceOf(address _owner) external view returns (uint256){
     return balances[_owner] ;
}

 function ownerOf(uint256 _tokenId) public view returns (address){
     return _owners[_tokenId];
 }

  modifier onlyOwner() {
        require(msg.sender == owner, "only owner can run this function");
        _;
    }

function safeMint(address _to, uint256 _tokenId) public onlyOwner returns(uint256){
    _owners[_tokenId]= _to;
    emit Transfer(address(0), _to, _tokenId);
    return _tokenId;
}

function safeTransferFrom(address _from, address _to, uint256 _tokenId) external {
    require(ownerOf(_tokenId) == _from, "Invalid token owner or not get approval");
    _owners[_tokenId]=_to;
}

function approve(address _approved, uint256 _tokenId) external {
    require(ownerOf(_tokenId)==msg.sender,"You aren't owner, how you can transfer ownership!");
    _owners[_tokenId] = _approved;
}


}