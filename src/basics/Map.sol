// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Map {
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => bool)) public friend;

    function set() external returns (uint256 bal) {
        balances[msg.sender] += 123;
        bal = balances[msg.sender];
        delete balances[msg.sender];
    }
}

contract IterMap {
    mapping(address => uint256) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;

    function set(address key, uint256 bal) external {
        balances[key] = bal;
        if (!inserted[key]) {
            inserted[key] = true;
            keys.push(key);
        }
    }

    function size() external view returns (uint256) {
        return keys.length;
    }
}
