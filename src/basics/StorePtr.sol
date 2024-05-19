// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract StorePtr {
    mapping(uint256 => bool) m;
    mapping(uint256 => mapping(uint256 => bool)) n;

    function verifyM() external returns (bool) {
        mapping(uint256 => bool) storage f = m;
        mapping(uint256 => bool) storage h = f;
        changeToTrue(h);
        return m[5];
    }

    function changeToTrue(mapping(uint256 => bool) storage u) internal {
        u[5] = true;
    }

    function verifyN() external returns (bool) {
        mapping(uint256 => bool) storage miniM = n[4];
        miniM[6] = true;
        return n[4][6];
    }
}
