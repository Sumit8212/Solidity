// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Storage {

    uint256 favoriteNumber;

    struct People {
        address user_id;
        string name;
        uint256 balance;
        uint256 loan;
        uint256 emi;
        uint256 timeperiod;
    }
    // uint256[] public anArray;

    People[] public people;
    mapping(string => uint256) public peopleDetails;

   
  
    function addPerson(address id, uint256 _favoriteNumber) public {
        people.push(People(user_id,name,balance,loan,emi,timeperiod));
        peopleDetails[id] = _favoriteNumber;
    }
}