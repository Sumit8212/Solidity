// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Hello {
    /// @notice Return an initialized string
    /// @return A string helloGeeks 
    function renderHellosFun () public pure returns (string memory) {
        return 'Hello how are you?';
    }
}