// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract MyContract {
    event NewNumber(uint256 number);
    
    function setNumber(uint256 _number) public {
        emit NewNumber(_number);
    }
}
