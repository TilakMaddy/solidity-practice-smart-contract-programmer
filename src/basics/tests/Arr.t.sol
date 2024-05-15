// SPDX-License-Identifier: UNLICENSE
pragma solidity 0.8.19;

import "lib/forge-std/src/Test.sol";
import "../Arr.sol";

contract ArrTest is Test {

    Arr a;

    function setUp() external {
        a = new Arr();
    }

    function testArr() public {
        console.log("before");
        console.log(a.example2().length);
        a.example3();
        console.log("after");
        console.log(a.example2().length);
    }

    function testPrint() public {
        console.log("abiencode12");
        console2.logBytes(abi.encode("a", "b"));
        console.log("abiencodepacked12");
        console2.logBytes(abi.encodePacked("a", "b"));
    }

}