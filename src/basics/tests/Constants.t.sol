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
        uint startGas = gasleft();
        c.MY_ADDRESS();
        uint constReadGasCost = startGas - gasleft();


        startGas = gasleft(); 
        v.MY_ADDRESS();
        uint varsReadGasCost = startGas - gasleft();

        console2.log(varsReadGasCost, constReadGasCost);
        assertGt(varsReadGasCost, constReadGasCost);

    }

}