// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract S {
    string public s_text;

    constructor(string memory _text) {
        s_text = _text;
    }
}

contract T {
    string public t_text;

    constructor(string memory _text) {
        t_text = _text;
    }
}

// There are 2 ways to call the parent's constructor

// If you need to determine constructor parameter based
contract U is S, T {
    constructor(string memory name) T(name) S(name) {

    }
}


// If you know the inputs when writing code
contract V is S("Hello"), T("Hello") {
    constructor() {

    }
}


// Combined style 
contract W is S("Hello"), T {
    constructor(string memory name) T(modifyName(name)) {

    }

    function modifyName(string memory oldName) internal pure returns (string memory newName) {
        newName = string.concat(oldName, " Sr.");
    }
}

// Order of initialzing depends on the order of inheritance declared
// in the first line of  contract definition. 
// (Not on the order in which they are called in the constr)

// IN all the examples above, first S() is called, then T(), then (U|V|W)()