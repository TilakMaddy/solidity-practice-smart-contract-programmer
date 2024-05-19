// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// If a function in a library is public,
// you'll have to deploy the library separately to interact with it

// If a function in a library is internal,
// it will be embedded into the contract using the library

library Math {
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a > b ? a : b;
    }
}

contract Libr {
    function getMax(uint256 a, uint256 b) external pure returns (uint256) {
        return Math.max(a, b);
    }
}

////////////////////////

library NiceArrayUtils {
    function indexOf(uint256[] storage arr, uint256 n) internal view returns (uint256) {
        uint256 length = arr.length;
        for (uint256 i = 0; i < length; ++i) {
            if (arr[i] == n) {
                return i;
            }
        }
        revert("Not found!");
    }
}

contract Array {
    uint256[] public arr = [1, 3, 5];

    function idx(uint256 n) external view returns (uint256) {
        return NiceArrayUtils.indexOf(arr, n);
    }
}

contract Array2 {
    using NiceArrayUtils for uint256[];

    uint256[] public arr = [1, 3, 5];

    function idx(uint256 n) external view returns (uint256) {
        return arr.indexOf(n);
    }

    function idx2(uint256 n) external view returns (uint256) {
        return NiceArrayUtils.indexOf(arr, n);
    }

    // function idx3(uint n) external view returns(uint) {
    //     uint[] memory h = new uint[](2);
    //     return NiceArrayUtils.indexOf(h, 1); <-- Not allowed!
    // }
}
