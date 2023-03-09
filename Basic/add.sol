// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Add{

    function getSum() public pure returns(uint){
    uint var1 =5;
    uint var2 = 10;
    uint result = var1+var2;
    return result;
    }
   
}