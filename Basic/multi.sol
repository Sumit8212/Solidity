// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract multi {
    function getMulti(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }

    function getMulti(uint256 c,uint256 d,uint256 e) public pure returns (uint256) {
        return c * d * e;
    }

    string name;
    uint256 roll;

    function setName(string memory n) public {
        name = n;
    }

    function getName() public view returns (string memory) {
        return name;
    }

    
}


