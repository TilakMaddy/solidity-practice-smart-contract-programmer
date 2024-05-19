// SPDX-License-Identifier: UNLICENSE
pragma solidity 0.8.19;

import "lib/forge-std/src/Test.sol";
import "../Constants.sol";

contract ConstantsTest is Test {
    Constants c;
    Vars v;

    function setUp() external {
        c = new Constants();
        v = new Vars();
    }

    function testGastCost() public view {
        uint256 startGas = gasleft();
        c.MY_ADDRESS();
        uint256 constReadGasCost = startGas - gasleft();

        startGas = gasleft();
        v.MY_ADDRESS();
        uint256 varsReadGasCost = startGas - gasleft();

        console2.log(varsReadGasCost, constReadGasCost);
        assertGt(varsReadGasCost, constReadGasCost);
    }
}
