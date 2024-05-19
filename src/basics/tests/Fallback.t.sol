// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "lib/forge-std/src/Test.sol";
import "../Fallback.sol";
import "lib/forge-std/src/Vm.sol";

contract FallbackTest is Test {
    Fallback fk;

    function setUp() external {
        fk = new Fallback();
        vm.deal(address(this), 1000);
    }

    error CallToNonExistentMethodFailed();

    function test_invokeUnknownMethod() public {
        (bool success1,) = address(fk).call{value: 100}(abi.encodeWithSignature("hello()"));
        if (!success1) {
            revert CallToNonExistentMethodFailed();
        }
        fk.haha();
    }
}
