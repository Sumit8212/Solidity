// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract dynamic_array {
    uint256[] public arr;

    function pushElement(uint256 value) public {
        arr.push(value);
    }

    function remove(uint256 index) public {
        delete arr[index];
    }

    function removeByValue(uint256 element) public{
        require(arr.length > 0 , "invalid");
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] == element) {
                delete arr[i];                
            }
        }
    }
}
