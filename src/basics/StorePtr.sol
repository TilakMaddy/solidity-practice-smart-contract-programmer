// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;


contract StorePtr {

    mapping(uint => bool) m;
    mapping(uint => mapping(uint => bool)) n;

    function verifyM() external returns(bool) {
        mapping(uint => bool) storage f = m;
        mapping(uint => bool) storage h = f;
        changeToTrue(h);
        return m[5];
    }

    function changeToTrue(mapping(uint => bool) storage u) internal {
        u[5] = true;
    }

    function verifyN() external returns(bool) {
        mapping(uint => bool) storage miniM = n[4];
        miniM[6] = true;
        return n[4][6];
    }


}