// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Map {
    mapping(address => uint) public balances;
    mapping(address => mapping(address => bool)) public friend;

    function set() external returns (uint bal) {
        balances[msg.sender] += 123;
        bal = balances[msg.sender];
        delete balances[msg.sender];
    }

}

contract IterMap {
    mapping(address => uint) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;

    function set(address key, uint bal) external {
        balances[key] = bal;
        if (!inserted[key]) {
            inserted[key] = true;
            keys.push(key);
        }
    }

    function size() external view returns(uint) {
        return keys.length;
    }    
    
}

