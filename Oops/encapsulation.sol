// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Person {
    string private name;
    uint256 private age;

    function setName(string memory _name) public {
        name = _name;
    }

    function setAge(uint256 _age) public {
        age = _age;
    }

    function getName() public view returns (string memory) {
        return name;
    }

    function getAge() public view returns (uint256) {
        return age;
    }
}
