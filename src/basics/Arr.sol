// SPDX-License-Identifier: UNLICENSED 
pragma solidity 0.8.19;

struct G {
    uint a;
    uint b;
}

contract Arr {
    uint[] public dynamicArray = [1, 2, 3];
    uint[3] public fixedArray;
    G[] public gs;

    function example(uint x) external returns(uint[] memory){
        dynamicArray.push(4);
        uint[] memory f = new uint[](x);
        return f;
    }

    function example2() external view returns(G[] memory){
        return gs;
    }

    function example3() external {
        gs.push(G({
            a: 3,
            b: 5
        }));
        G[] storage h = gs; // Pointer
        h.push(G({
            a: 9,
            b: 2
        }));
    }

}