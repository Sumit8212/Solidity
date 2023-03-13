// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract Enum{

    enum user {allowed,not_allowed,wait}
    user public u1 = user.wait;


    enum State {Inactive, Active}
    
    State public currentState = State.Inactive;
    
    function activate() public {
        currentState = State.Active;
    }


}