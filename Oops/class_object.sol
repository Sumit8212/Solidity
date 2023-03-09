// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;


contract Car {
    string public make;
    string public model;
    uint public year;

    constructor(string memory _make, string memory _model, uint _year) {
        make = _make;
        model = _model;
        year = _year;
    }

    function getMake() public view returns (string memory) {
        return make;
    }

    function setMake(string memory _make) public {
        make = _make;
    }

    function getModel() public view returns (string memory) {
        return model;
    }

    function setModel(string memory _model) public {
        model = _model;
    }

    function getYear() public view returns (uint) {
        return year;
    }

    function setYear(uint _year) public {
        year = _year;
    }
}


