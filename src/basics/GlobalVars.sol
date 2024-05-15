// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract GlobalVariables {
    // View because you are reading global variables
    function globalVars() external view returns(address, uint, uint) {
        address sender = msg.sender;
        uint timestamp = block.timestamp;
        uint number = block.number;
        return (sender, timestamp, number);
    }

}

