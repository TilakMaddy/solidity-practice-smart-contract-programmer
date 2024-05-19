// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Ownable {
    address payable public immutable owner = payable(msg.sender);

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed!");
        _;
    }
}

contract Me is Ownable {
    event Log(address who);

    function something() public onlyOwner {
        emit Log(owner); // emitting to the blockchain is a tx
    }
}
