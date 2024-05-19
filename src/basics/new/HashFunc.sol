// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract HashFunc {
    function hashIt(string memory text, uint256 number, address addr) external pure returns (bytes32) {
        // We need to first encode it into bytes by using abi.encodePacked(arg)
        return keccak256(abi.encodePacked(text, number, addr));
    }

    // Hash Collision is possible when there is
    // abi.encodePacked will compress data (no padding)

    function encode(string memory text0, string memory text1) external pure returns (bytes memory) {
        return abi.encode(text0, text1);
    }

    function encodePacked(string memory text0, string memory text1) external pure returns (bytes memory) {
        return abi.encodePacked(text0, text1);
    }
}
