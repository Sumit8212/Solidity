// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Send_ether {
    address admin;

    constructor() {
        admin = msg.sender;
    }

    receive() external payable {}

    function sendMoney(address payable receiver) public payable {
        require(msg.value != 0, "please send some amount");
        require(receiver != address(0), "zero address is not allowed");
        uint256 platformFee = ((msg.value) * 5) / 100; //5%fees
        receiver.transfer(msg.value - platformFee);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getMyBalance() public view returns (uint256) {
        return msg.sender.balance;
    }

    function withdrawContractBal() public {
        uint256 money = address(this).balance;
        require(admin == msg.sender, "not allowed");
        payable(admin).transfer(money);
    }
}
