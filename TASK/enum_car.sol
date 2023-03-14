// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Enum_car{

    enum car{ignition_off, ignition_on}

    car public ignitionState = car.ignition_off;

    function ignition_On()public{
        ignitionState = car.ignition_on;
    }

    function ignition_Off()public{
         ignitionState = car.ignition_off;
    }
    
}