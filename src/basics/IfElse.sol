// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract IfElse {
    function ternary(uint _x) external pure returns(uint) {
        return _x >= 10 ? 1 : 11;
    }
}