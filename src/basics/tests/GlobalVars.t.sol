// SPDX-License-Identifier: UNLICENSE
pragma solidity 0.8.19;

import "lib/forge-std/src/Test.sol";
import "../GlobalVars.sol";

contract GlobalVarsTest is Test {

    GlobalVariables gvContract;

    function setUp() external {
        gvContract = new GlobalVariables();
    }

    function testGlobalVars() public view {
        (address a, uint b, uint c) = gvContract.globalVars();
        console2.log("Global variables ");
        console2.log(a, b, c);
        assertEq(b, 1);
        assertEq(c, 1);
    }

}