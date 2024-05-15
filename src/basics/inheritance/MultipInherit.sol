// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Order of inheritance - most based to most derived

/*

  X
 /|
Y |
 \|
  Z

*/

// contract X {}
// contract Y is X {}
// contract Z is X, Y {}  // You should declare frommost based to most derived

/**

    In contract Z,
    When customizing a function that you are inheriting from X and Y

    you should specify `override(X, Y)` (order of x and y doesn't matter) in the function def

 */


/*

   X
  /  \ 
Y     A
|     |
|     B
 \   /
   Z
*/

// contract X {}
// contract Y is X {}
// contract A is X {}
// contract B is X, A {}
// contract Z is X, A, Y, B {}

/*
Error:
Compiler run failed:
Error (5005): Linearization of inheritance graph impossible
  --> src/basics/inheritance/MultipInherit.sol:35:1:
   |
35 | contract Z is X, B, A, Y {}
   | ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 */