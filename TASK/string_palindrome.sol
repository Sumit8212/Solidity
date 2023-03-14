// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Palindrome {
    function checkPalindrome(string memory str) public pure returns (bool) {
        bytes memory b = bytes(str);
        uint256 min = 0;
        uint256 max = b.length - 1;
        while (min < max) {
            if (b[min] != b[max]) {
                return false;
            }
            min++;
            max--;
        }
        return true;
    }
}
