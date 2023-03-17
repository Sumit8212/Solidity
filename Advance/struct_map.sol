// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Storage {

    uint256 favoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;

    }
    // uint256[] public anArray;

    People[] public people;
    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public {

        favoriteNumber = _favoriteNumber;

    }
    function retrieve() public view returns (uint256) {
        return favoriteNumber;

    }
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}