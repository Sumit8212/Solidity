// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
import "solidity-string-utils/StringUtils.sol";

contract MyContract {
    struct user {
        address user_id;
        string name;
        uint256 balance;
        uint256 loan;
        uint256 emi;
        uint256 timeperiod;
    }

    user[] public allUser;
    address admin;
    user public u1;

    receive() external payable {}

    fallback() external payable {}

    constructor() {
        admin = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == admin, "You're not the smart contract admin!");
        _;
    }

    function addFund() public payable onlyOwner {
        // require(admin == msg.sender, "not allowed");
        payable(address(this)).transfer(msg.value);
    }

    mapping(address => user) public users;

    function deposit(address payable account, uint256 amount) public payable {
        u1.balance += amount;
        users[account] = user(u1.user_id,u1.name,u1.balance,u1.loan,u1.emi,u1.timeperiod);
    }

    function Loan(
        address payable account,
        uint256 amount,
        uint256 month,string memory _input
    ) public payable {
        uint si;
        account.transfer(amount);
        u1.balance += amount;
        u1.timeperiod += month;
        require(keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("car")) || keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("home")) || keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("personal")), "invalid loan type");
        if(keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("car"))){
         si = (amount*8*month)/1200;
        }else if(keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("home"))) {
         si = (amount*6*month)/1200;
        }else if(keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("personal"))) {
         si = (amount*10*month)/1200;
        }
        uint finalAmount=amount+si;
        u1.loan=finalAmount;
        u1.emi=u1.loan/month;
        users[account] = user(u1.user_id,u1.name,u1.balance,u1.loan,u1.emi,u1.timeperiod);
    }

    //  function homeLoan(
    //     address payable account,
    //     uint256 amount,
    //     uint256 month,string memory _input
    // ) public payable {
    //     account.transfer(amount);
    //     u1.balance += amount;
    //     u1.timeperiod += month;
    //     require(keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("car")));
    //     uint si = (amount*8*month)/1200;
    //     uint finalAmount=amount+si;
    //     u1.loan=finalAmount;
    //     u1.emi=u1.loan/month;
    //     users[account] = user(u1.user_id,u1.name,u1.balance,u1.loan,u1.emi,u1.timeperiod);
    // }

    //  function personalLoan(
    //     address payable account,
    //     uint256 amount,
    //     uint256 month,string memory _input
    // ) public payable {
    //     account.transfer(amount);
    //     u1.balance += amount;
    //     u1.timeperiod += month;
    //     require(keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("car")));
    //     uint si = (amount*8*month)/1200;
    //     uint finalAmount=amount+si;
    //     u1.loan=finalAmount;
    //     u1.emi=u1.loan/month;
    //     users[account] = user(u1.user_id,u1.name,u1.balance,u1.loan,u1.emi,u1.timeperiod);
    // }

    function withdraw(address payable account, uint amount)public{
        require(amount>0 && amount<u1.balance, "invalid amount");
        u1.balance-=amount;
        users[account] = user(u1.user_id,u1.name,u1.balance,u1.loan,u1.emi,u1.timeperiod);
    }

    function payEmi(address payable account)public{
      require(u1.timeperiod>0 && u1.balance>0, "EMI NOT PAID");
      u1.balance-=u1.emi;
      u1.loan-=u1.emi;
      u1.timeperiod--;
      users[account] = user(u1.user_id,u1.name,u1.balance,u1.loan,u1.emi,u1.timeperiod);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getUser(address user_id) public view returns (user memory) {
        return users[user_id];
    }


}
