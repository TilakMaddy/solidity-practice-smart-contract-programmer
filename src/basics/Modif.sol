// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract M {
    uint256 count;

    modifier sandwich(uint256 c) {
        count += c;
        _;
        count *= 2;
    }

    function a() public sandwich(5) {
        count = 8;
    }
}
