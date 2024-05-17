// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/* A piggy bank is a place where anyone can deposit money, but in order
 * to withdraw the money you have to destroy the device. Here the device is the
 * contract and the wothdrawer is the piggy bank owner.
 */

contract PiggyBank {
    address private immutable owner;
    event Withdraw(address to);
    event Deposit(uint amount);

    constructor() {
        owner = msg.sender;
    }

    receive() external payable { 
        emit Deposit(msg.value);
    }

    function withdraw() external {
        // Checks
        require(msg.sender == owner, "you are not the owner!");

        // Effects
        selfdestruct(payable(msg.sender));
        emit Withdraw(msg.sender); // not sure if we can call this after selfdestruct
    }
}