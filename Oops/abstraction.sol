// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

abstract contract Calculator  {
   function getResult() public virtual view returns(uint);
}
contract Test is Calculator {
   function getResult() public override pure returns(uint) {
      uint a = 1;
      uint b = 2;
      uint result = a + b;
      return result;
   }
}