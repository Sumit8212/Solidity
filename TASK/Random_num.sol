// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Random_num{

    // function random_num()public pure returns(uint){
    //     returm
    // }

     uint randNonce = 0;
 
    // Defining a function to generate
    // a random number
    function randMod(uint _modulus) external returns(uint)
    {
        // increase nonce
        randNonce++;
       uint ran= uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) % _modulus;
        return ran;
    }
}