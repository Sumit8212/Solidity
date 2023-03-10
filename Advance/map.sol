// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;


struct student{
    string name;
    uint class;
}
contract test{
    mapping(uint => string)public map_id;

    function setter(uint keys, string memory value)public{
        map_id[keys]=value;
    }

   mapping(uint =>student)public data;

   function setter1(uint roll, string memory name, uint class)public{
       data[roll]= student(name,class);
   }
}