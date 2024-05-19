// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract FunctionSelector {
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }

    function getSelector2(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(abi.encodePacked(_func)));
    }
}

contract Receiver {
    event Log(bytes data);

    function transfer() external {
        emit Log(msg.data);
    }
}

/*
contract WontCompile {

	function collate_propagate_storage(bytes16 x) external {
	}

	function burn(uint256 amount) external {}
}*/
