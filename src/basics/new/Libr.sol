// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// If a function in a library is public,
// you'll have to deploy the library separately to interact with it

// If a function in a library is internal,
// it will be embedded into the contract using the library


library Math {
    function max(uint a, uint b) internal pure returns(uint) {
        return a > b ? a : b;
    }
}

contract Libr {
    function getMax(uint a, uint b) external pure returns(uint) {
        return Math.max(a, b);
    }
}

////////////////////////

library NiceArrayUtils {
    function indexOf(uint[] storage arr, uint n) internal view returns(uint) {
        uint length = arr.length;
        for (uint i = 0; i < length; ++i) {
            if (arr[i] == n) {
                return i;
            }
        }
        revert("Not found!");
    }
}

contract Array {
    uint[] public arr = [1, 3, 5];

    function idx(uint n) external view returns(uint) {
        return NiceArrayUtils.indexOf(arr, n);
    }
}


contract Array2 {
    using NiceArrayUtils for uint[];
    uint[] public arr = [1, 3, 5];

    function idx(uint n) external view returns(uint) {
        return arr.indexOf(n);
    }

    function idx2(uint n) external view returns(uint) {
        return NiceArrayUtils.indexOf(arr, n);
    }

    // function idx3(uint n) external view returns(uint) {
    //     uint[] memory h = new uint[](2);
    //     return NiceArrayUtils.indexOf(h, 1); <-- Not allowed!
    // }
}