// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

struct G {
    uint256 a;
    uint256 b;
}

contract Arr {
    uint256[] public dynamicArray = [1, 2, 3];
    uint256[3] public fixedArray;
    G[] public gs;

    function example(uint256 x) external returns (uint256[] memory) {
        dynamicArray.push(4);
        uint256[] memory f = new uint256[](x);
        return f;
    }

    function example2() external view returns (G[] memory) {
        return gs;
    }

    function example3() external {
        gs.push(G({a: 3, b: 5}));
        G[] storage h = gs; // Pointer
        h.push(G({a: 9, b: 2}));
    }
}
