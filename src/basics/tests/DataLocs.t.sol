// SPDX-License-Identifier: UNLICENSE
pragma solidity 0.8.19;

import "lib/forge-std/src/Test.sol";
import "../DataLocations.sol";

contract DL is Test {

    DataLocations a;

    function setUp() external {
        a = new DataLocations();
    }

    function testDL() public {
        uint[] memory numbers = new uint[](2);
        a.playWithLoc(numbers, numbers);
    }

}