// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "lib/forge-std/src/Test.sol";
import "lib/forge-std/src/console2.sol";

import "../new/HashFunc.sol";

contract FancyHashFuncTest is Test {
    error DeploymentFailed();

    HashFunc hashFunc;

    function setUp() external {
        bytes memory creationCode = type(HashFunc).creationCode;

        address deployedAddr;
        bytes32 creationCodeLength;

        assembly {
            creationCodeLength := mload(creationCode)
            deployedAddr := create(0, add(creationCode, 0x20), creationCodeLength)
        }

        console2.log("Creation Code Length: ");
        console2.logBytes32(creationCodeLength);

        if (deployedAddr == address(0)) {
            revert DeploymentFailed();
        }

        hashFunc = HashFunc(deployedAddr);
    }

    function test_basicHashingFunction() public {
        bytes32 hashValue = hashFunc.hashIt("Ethereum", 2024, address(2024));
        console2.logBytes32(hashValue);
    }

    function test_encode() public {
        bytes memory encoded = hashFunc.encode("Eth", "ereum");
        console2.logBytes(encoded);
    }

    /* Hash collision can be encountered on below functions 
        bytes32 a = keccak256(abi.encodePacked("Eth", "ereum"))
        bytes32 b = keccak256(abi.encodePacked("Et", "hereum"))

        a == b !!
        
    */

    function test_encodePacked() public {
        bytes memory encoded = hashFunc.encodePacked("Eth", "ereum");
        console2.logBytes(encoded);
    }

    function test_encodePacked2() public {
        bytes memory encoded = hashFunc.encodePacked("Et", "hereum");
        console2.logBytes(encoded);
    }

    /* Solutions

    1) Stick to abi.encode()
    2) If you want to use abi.encodePacked():
        make sure that the dynamic data types like strings, bytes,
        are not next to each other and put uint in between
        - The said uint should be constant value (i infer) 
        
    */
}
