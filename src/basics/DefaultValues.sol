// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract DefaultValues {
    bool public b; // false
    uint256 public u; // 0
    int256 public i; // 0
    address public a; // 0x0000000000000000000000000000000000000000 (40 zeroes) 20 bytes
    bytes32 public b32; // 0x0000000000000000000000000000000000000000000000000000000000000000 (64 zeroes) 32 bytes
}

/*
In each byte, you can store 2 hex characters
*/
