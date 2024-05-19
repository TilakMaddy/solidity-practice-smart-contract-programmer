// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract GlobalVariables {
    // View because you are reading global variables
    function globalVars() external view returns (address, uint256, uint256) {
        address sender = msg.sender;
        uint256 timestamp = block.timestamp;
        uint256 number = block.number;
        return (sender, timestamp, number);
    }
}
