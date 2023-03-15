// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract MyContract {
    struct user {
        string name;
        uint256 balance;
        uint256 loan;
        uint256 emi;
        uint256 timeperiod;
    }
    address admin;
    user public u1;

    receive() external payable {}
    fallback() external payable{}

    constructor() {
        admin = msg.sender;
    }

    // function fund() public payable{
    //     u1.balance+=msg.value;
    // }

    function withdraw() public payable{
        
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
