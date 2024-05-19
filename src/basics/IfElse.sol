// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract IfElse {
    function ternary(uint256 _x) external pure returns (uint256) {
        return _x >= 10 ? 1 : 11;
    }
}
