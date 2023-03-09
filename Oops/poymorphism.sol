// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract parent {
    uint256 internal sum;

    function setValue(uint256 _num1, uint256 _num2) public {
        sum = _num1 + _num2;
    }

    function getValue() public view virtual returns (uint256) {
        return 1;
    }
}

// child contract
contract child is parent {
    function getValue() public view override returns (uint256) {
        return sum;
    }
}

// Defining calling contract
contract ContractPolymorphism {
    // Creating object
    parent pc = new child();

    function getInput(uint256 _num1, uint256 _num2) public {
        pc.setValue(_num1, _num2);
    }

    function getSum() public view returns (uint256) {
        return pc.getValue();
    }
}
