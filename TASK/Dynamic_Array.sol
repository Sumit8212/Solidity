// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract dynamic_array{

    uint[]public arr;

    function pushElement(uint value)public {
         arr.push(value);
    }
   function remove(uint index) public{
    delete arr[index];
  }
  function removeByValue(uint valueRemove)public{
      for(uint i=0; i<arr.length; i++){
          if(arr[i]==valueRemove){
              delete arr[i];
          }
      }
  }
}