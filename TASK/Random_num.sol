// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Random_num {

    // Defining a function to generate
    // a random number
    function randMod() public view returns (uint256) {
        uint random = uint256(keccak256(abi.encodePacked(block.timestamp)));
        return (random % 100);
    }
}
