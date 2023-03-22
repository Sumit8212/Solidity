// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract MyContract {
    struct user {
        address user_id;
        uint256 balance;
        uint256 carLoan;
        uint256 homeLoan;
        uint256 personalLoan;
        uint256 carEmi;
        uint256 homeEmi;
        uint256 personalLoanEmi;
        uint256 carLoanTimeperiod;
        uint256 homeLoanTimeperiod;
        uint256 personalLoanTimeperiod;
        uint256 timestamp;
    }
    user public u1;

    function setTime() internal {
        u1.timestamp = block.timestamp;
    }

    address admin;

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
        require(account != address(0), "zero address is not allowed");
        require(amount != 0, "please send some amount");
        users[account].balance += amount;
        users[account] = user(
            users[account].user_id,
            users[account].balance,
            users[account].carLoan,
            users[account].homeLoan,
            users[account].personalLoan,
            users[account].carEmi,
            users[account].homeEmi,
            users[account].personalLoanEmi,
            users[account].carLoanTimeperiod,
            users[account].homeLoanTimeperiod,
            users[account].personalLoanTimeperiod,
            users[account].timestamp
        );
    }

    function Loan(
        address payable account,
        uint256 amount,
        uint256 month,
        string memory _input
    ) public payable {
        require(account != address(0), "zero address is not allowed");
        require(amount != 0, "please send some amount");
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
            users[account].carLoanTimeperiod += month;
            // users[account].carLoan += amount + carSI;
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
            users[account].homeEmi = users[account].homeLoan / month;
            users[account].homeLoanTimeperiod += month;
            // users[account].homeLoan += amount + homeSI;
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
            users[account].personalLoanEmi =
                users[account].personalLoan /
                month;
            users[account].personalLoanTimeperiod += month;
            // users[account].personalLoan += amount + personalSI;
        }

        users[account] = user(
            users[account].user_id,
            users[account].balance,
            users[account].carLoan,
            users[account].homeLoan,
            users[account].personalLoan,
            users[account].carEmi,
            users[account].homeEmi,
            users[account].personalLoanEmi,
            users[account].carLoanTimeperiod,
            users[account].homeLoanTimeperiod,
            users[account].personalLoanTimeperiod,
            users[account].timestamp
        );
    }

    function withdraw(address payable account, uint256 amount) public {
        require(
            amount > 0 && amount < users[account].balance,
            "invalid amount"
        );
        require(account != address(0), "zero address is not allowed");
        require(amount != 0, "please send some amount");
        users[account].balance -= amount;
        users[account] = user(
            users[account].user_id,
            users[account].balance,
            users[account].carLoan,
            users[account].homeLoan,
            users[account].personalLoan,
            users[account].carEmi,
            users[account].homeEmi,
            users[account].personalLoanEmi,
            users[account].carLoanTimeperiod,
            users[account].homeLoanTimeperiod,
            users[account].personalLoanTimeperiod,
            users[account].timestamp
        );
    }

    function payEmi(address payable account, string memory _input) public {
        require(
            keccak256(abi.encodePacked(_input)) ==
                keccak256(abi.encodePacked("car")) ||
                keccak256(abi.encodePacked(_input)) ==
                keccak256(abi.encodePacked("home")) ||
                keccak256(abi.encodePacked(_input)) ==
                keccak256(abi.encodePacked("personal")),
            "invalid loan type"
        );
        require(account != address(0), "zero address is not allowed");
        if (
            keccak256(abi.encodePacked(_input)) ==
            keccak256(abi.encodePacked("car"))
        ) {
            require(
                block.timestamp - users[account].timestamp > 30 days,
                "Need to wait 1 month after paying last EMI"
            );
            users[account].timestamp = block.timestamp;
            require(users[account].carLoanTimeperiod > 0, "invalid emi amount");
            users[account].balance -= users[account].carEmi;
            users[account].carLoan -= users[account].carEmi;
            users[account].carLoanTimeperiod--;
        } else if (
            keccak256(abi.encodePacked(_input)) ==
            keccak256(abi.encodePacked("home"))
        ) {
            require(
                block.timestamp - users[account].timestamp > 30 days,
                "Need to wait 1 month after paying last EMI"
            );
            users[account].timestamp = block.timestamp;
            require(
                users[account].homeLoanTimeperiod > 0,
                "invalid emi amount"
            );
            users[account].balance -= users[account].homeEmi;
            users[account].homeLoan -= users[account].homeEmi;
            users[account].homeLoanTimeperiod--;
        } else if (
            keccak256(abi.encodePacked(_input)) ==
            keccak256(abi.encodePacked("personal"))
        ) {
            require(
                block.timestamp - users[account].timestamp > 30 days,
                "Need to wait 1 month after paying last EMI"
            );
            users[account].timestamp = block.timestamp;
            require(
                users[account].personalLoanTimeperiod > 0,
                "invalid emi amount"
            );
            users[account].balance -= users[account].personalLoanEmi;
            users[account].personalLoan -= users[account].personalLoanEmi;
            users[account].personalLoanTimeperiod--;
        }

        users[account] = user(
            users[account].user_id,
            users[account].balance,
            users[account].carLoan,
            users[account].homeLoan,
            users[account].personalLoan,
            users[account].carEmi,
            users[account].homeEmi,
            users[account].personalLoanEmi,
            users[account].carLoanTimeperiod,
            users[account].homeLoanTimeperiod,
            users[account].personalLoanTimeperiod,
            users[account].timestamp
        );
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function carLoanDetails(address account)
        public
        view
        returns (
            uint256 loanAmount,
            uint256 montlyEmi,
            uint256 timeperiod
        )
    {
        require(account != address(0), "zero address is not allowed");
        return (
            users[account].carLoan,
            users[account].carEmi,
            users[account].carLoanTimeperiod
        );
    }

    function homeLoanDetails(address account)
        public
        view
        returns (
            uint256 loanAmount,
            uint256 montlyEmi,
            uint256 timeperiod
        )
    {
        require(account != address(0), "zero address is not allowed");
        return (
            users[account].homeLoan,
            users[account].homeEmi,
            users[account].homeLoanTimeperiod
        );
    }

    function personalLoanDetails(address account)public view returns (uint256 loanAmount,uint256 montlyEmi,uint256 timeperiod)
    {
        require(account != address(0), "zero address is not allowed");
        return (
            users[account].personalLoan,
            users[account].personalLoanEmi,
            users[account].personalLoanTimeperiod
        );
    }
}
