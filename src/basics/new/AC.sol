// SPDX-License-Identifier: UNLICENSE
pragma solidity 0.8.19;
/**
 *
 *
 * mapping(uint => bool) a;
 *
 * bool storage m = a[4]
 * m = true
 *
 *
 * is a[4] true ??? NO !! you cannot have bool storage - compiler error
 *
 *
 * ---
 *
 * selfdestruct(payable(msg.sender)) -> suicides and force sends money
 */
