// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

// Parent contract
contract Vehicle {
    uint public mileage;
    uint public year;

    constructor(uint _mileage, uint _year) {
        mileage = _mileage;
        year = _year;
    }   
}


// Child contract 
contract Car is Vehicle {
    string public make;
    string public model;

    constructor(string memory _make, string memory _model, uint _mileage, uint _year) 
        Vehicle(_mileage, _year)
    {
        make = _make;
        model = _model;
    }
}
