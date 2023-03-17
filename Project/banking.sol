// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;
import "solidity-string-utils/StringUtils.sol";

contract MyContract {
    struct user {
        address user_id;
        // string name;
        uint256 balance;
        uint256 loan;
        uint256 emi;
        uint256 timeperiod;
        uint256 carLoan;
        uint256 homeLoan;
        uint256 personalLoan;
        uint256 carEmi;
    }

    address admin;

    // user public u1;

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
        users[account].balance += amount;
        users[account] = user(
            users[account].user_id,
            users[account].balance,
            users[account].loan,
            users[account].emi,
            users[account].timeperiod,
            users[account].carLoan,
            users[account].homeLoan,
            users[account].personalLoan,
            users[account].carEmi
        );
    }

    function Loan(
        address payable account,
        uint256 amount,
        uint256 month,
        string memory _input
    ) public payable {
        account.transfer(amount);
        users[account].balance += amount;
        // uint carSI;
        // require(users[account].carLoan<1 && users[account].homeLoan<1 && users[account].personalLoan<1, "you have one pending loan! you can't take another!");
        require(
            keccak256(abi.encodePacked(_input)) ==
                keccak256(abi.encodePacked("car")) ||
                keccak256(abi.encodePacked(_input)) ==
                keccak256(abi.encodePacked("home")) ||
                keccak256(abi.encodePacked(_input)) ==
                keccak256(abi.encodePacked("personal")),
            "invalid loan type"
        );
        if (
            keccak256(abi.encodePacked(_input)) ==
            keccak256(abi.encodePacked("car"))
        ) {
            require(
                users[account].carLoan < 1,
                "you have one car loan! you can't take another!"
            );
            uint256 carSI = (amount * 8 * month) / 1200;
            users[account].carLoan = amount + carSI;
            users[account].carEmi = users[account].carLoan / month;
            users[account].timeperiod += month;
            users[account].loan += amount + carSI;
        } else if (
            keccak256(abi.encodePacked(_input)) ==
            keccak256(abi.encodePacked("home"))
        ) {
            require(
                users[account].homeLoan < 1,
                "you have already one home loan! you can't take another!"
            );
            uint256 homeSI = (amount * 6 * month) / 1200;
            uint256 finalAmountHome = amount + homeSI;
            users[account].homeLoan = finalAmountHome;
            users[account].emi = users[account].homeLoan / month;
            users[account].timeperiod += month;
            users[account].loan += amount + homeSI;
        } else if (
            keccak256(abi.encodePacked(_input)) ==
            keccak256(abi.encodePacked("personal"))
        ) {
            require(
                users[account].personalLoan < 1,
                "you have one personal loan! you can't take another!"
            );
            uint256 personalSI = (amount * 10 * month) / 1200;
            uint256 finalAmountPersonal = amount + personalSI;
            users[account].personalLoan = finalAmountPersonal;
            users[account].emi = users[account].personalLoan / month;
            users[account].timeperiod += month;
            users[account].loan += amount + personalSI;
        }

        users[account] = user(
            users[account].user_id,
            users[account].balance,
            users[account].loan,
            users[account].emi,
            users[account].timeperiod,
            users[account].carLoan,
            users[account].homeLoan,
            users[account].personalLoan,
            users[account].carEmi
        );
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

    function withdraw(address payable account, uint256 amount) public {
        require(
            amount > 0 && amount < users[account].balance,
            "invalid amount"
        );
        users[account].balance -= amount;
        users[account] = user(
            users[account].user_id,
            users[account].balance,
            users[account].loan,
            users[account].emi,
            users[account].timeperiod,
            users[account].carLoan,
            users[account].homeLoan,
            users[account].personalLoan,
            users[account].carEmi
        );
    }

    // function showLoanDetails(string memory loanType)public{
    //     require(keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("car")) || keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("home")) || keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("personal")), "invalid loan type");
    //     if(keccak256(abi.encodePacked(_input)) == keccak256(abi.encodePacked("car")){

    //     }
    // }

    function payEmi(address payable account) public {
        // require(
        //     users[account].timeperiod > 0 && users[account].balance > 0,
        //     "EMI NOT PAID"
        // );
        account.transfer(address(this).balance);
        users[account].balance -= users[account].carEmi;
        users[account].carLoan -= users[account].carEmi;
        users[account].timeperiod--;
        users[account] = user(
            users[account].user_id,
            users[account].balance,
            users[account].loan,
            users[account].emi,
            users[account].timeperiod,
            users[account].carLoan,
            users[account].homeLoan,
            users[account].personalLoan,
            users[account].carEmi
        );
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // function getUser(address user_id) public view returns (user memory) {
    //     return users[user_id];
    // }

    function carLoanDetails(address account) public view returns(uint,uint,uint){
        return (users[account].carLoan,users[account].carEmi,users[account].timeperiod);
    }
     function homeLoanDetails(address account) public view returns(uint,uint,uint){
        return (users[account].homeLoan,users[account].carEmi,users[account].timeperiod);
    }
     function personalLoanDetails(address account) public view returns(uint,uint,uint){
        return (users[account].personalLoan,users[account].carEmi,users[account].timeperiod);
    }
}
