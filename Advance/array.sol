// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Array {
    uint256[5] public arr = [11, 22, 33, 44, 55];

    function length() public view returns (uint256) {
        return arr.length;
    }

    function setValue(uint256 index, uint256 value) public {
        arr[index] = value;
    }

    uint[]public arr1;

    function pushElem(uint value1)public{
        arr1.push(value1);
    }

    function popElem()public{
        arr1.pop();
    }
    
}
