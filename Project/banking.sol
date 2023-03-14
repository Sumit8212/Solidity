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

    user public u1;

    mapping(address => uint256) private balances;
    address public owner;
    event LogDepositMade(address accountAddress, uint256 amount);

    constructor() public {
        owner = msg.sender;
    }

    // function deposit() public payable {
    //     u1.balance += msg.value;
    // }
    function deposit() public payable returns (uint256) {
        require((balances[msg.sender] + msg.value) >= balances[msg.sender]);
        balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }

    function withdraw(uint256 withdrawAmount)
        public
        payable
        returns (uint256 remainingBal)
    {
        require(withdrawAmount <= balances[msg.sender]);
        balances[msg.sender] -= withdrawAmount;
        msg.sender.transfer(withdrawAmount);
        return balances[msg.sender];
    }
}
