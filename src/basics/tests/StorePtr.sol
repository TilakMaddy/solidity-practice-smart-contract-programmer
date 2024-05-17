// SPDX-License-Identifier: UNLICENSE
pragma solidity 0.8.19;

import "lib/forge-std/src/Test.sol";
import "../StorePtr.sol";

contract StorePtrTest is Test {

    StorePtr a;

    function setUp() external {
        a = new StorePtr();
    }

    function testSig() public {
        assertEq(a.verifyM(), true);
        assertEq(a.verifyN(), true);
    }

}