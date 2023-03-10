// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

interface MyInterface {
    function myFunction(uint256 _para) external returns (bool);
}

contract MyContract is MyInterface {
    function myFunction(uint256 _para) pure external returns (bool) {
        uint256 a = _para;
        return true;
    }
}
