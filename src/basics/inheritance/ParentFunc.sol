// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;


// This doesn't work

// contract E {
//     function logSomething() public pure {

//     }
// }

// contract F {
//     function run() public pure {
//         E.logSomething();
//     }
// }

// Error:
// Compiler run failed:
// Error (3419): Cannot call function via contract type name.
//   --> src/basics/inheritance/ParentFunc.sol:12:9:
//    |
// 12 |         E.logSomething();
//    |         ^^^^^^^^^^^^^^^^


contract E {

    function doSomething() public virtual pure {
        E.logSomething(); // This works !!!
    }

    function logSomething() public pure {

    }
}

contract F is E {

    // First way of calling parent functions
    function doSomething() public virtual override pure {
        E.logSomething(); // This works !!!
    }

    // Second way of calling parent functions
    function doSomethingAgain() public virtual pure {
        super.logSomething(); 
    }

}


contract G is E {

    // First way of calling parent functions
    function doSomething() public virtual override pure {
        E.logSomething(); // This works !!!
    }

    // Second way of calling parent functions
    function doSomethingAgain() public virtual pure {
        super.logSomething(); 
    }

}

// BUT there is a difference in both ways!
// super -> can resolve to multiple parents (based on is F, G) and make multiple calls (F.foo(), and G.foo())

contract H is F, G {
    function doSomething() public override(F, G) pure {

    }
    function doSomethingAgain() public override(F, G) pure {

    }
}
