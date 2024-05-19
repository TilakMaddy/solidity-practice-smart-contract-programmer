// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Fallback {
    event Log1(string indexed funcName, address indexed who, uint256 indexed cash, bytes data);
    event Log2(string indexed funcName, address indexed who, uint256 indexed cash);

    /**
     * Fallback function is executed when the callee function doesn't exist
     *     (or) when you directly send ETH to the contrat
     */

    // optionally payable
    fallback() external payable {
        emit Log1("fallback", msg.sender, msg.value, msg.data);
    }

    /**
     * If money is send +  msg.data is empty,
     *     receive is executed (if not declared it falls back to fallback())
     */

    // has to be payable
    receive() external payable {
        emit Log2("receive", msg.sender, msg.value);
    }

    function haha() public {
        (bool success1,) = address(this).call{value: 100}("");
        require(success1);
    }
}

// send 2300 gas, bool returned
// transfer 2300 gas, reverts
// call - all gas, bool returned, bytes memory data returned
