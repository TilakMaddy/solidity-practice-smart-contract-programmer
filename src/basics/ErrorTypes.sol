// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/*
    Gas will be refunded and state updates are reverted
*/

contract ErrorTypes {
    function testRequire(uint x) external pure {
        require(x < 10, "x is greater than or eq 10");
    }

    /* revert is better to use when condition to check is complex */
    function testRevert(uint x) external pure {
        if (x >= 5) {
            if (x >= 6) {
                if (x >= 10) {
                    revert("x is greater than or eq to 10");
                }
            }
        }
        // Alt: require(x >= 5 && x >= 6 && x >= 10, "x is greater than ..");
    }

    function testAssert() external {
        // If assert is false, then there is a bug in your smart contract
        // assert(num == 123);
    }

    error MyErr(string sdf);

    function useCustom() external pure {
        revert MyErr("");
    }

}