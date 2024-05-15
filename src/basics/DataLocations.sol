// SPDX-License-Identifier: MIT 
pragma solidity 0.8.19;

import "lib/forge-std/src/console2.sol";

contract DataLocations {

    function _modifySecondNumber(uint[] memory numbers, uint m) internal pure {
        numbers[1] = m;
    }


    function getOnePlusSecondNumberMeme(uint[] memory numbers) public pure returns(uint) {
        return numbers[1] + 1;
    }

    function playWithLoc(uint[] memory numbers, uint[] calldata cnums) external pure {
        require(numbers.length == 2);
        numbers[0] = 10;
        _modifySecondNumber(numbers, 50);

        // Log 2nd number after modifying
        console2.log(numbers[1]); // prints 50

        uint[] memory NOTAcopy = numbers;
        _modifySecondNumber(NOTAcopy, 90);
        console2.log(numbers[1]); // print 90


        /* You can pass calldata arguments to memory and calldata */
        getOnePlusSecondNumber(cnums);
        getOnePlusSecondNumberMeme(cnums);

        /* You can pass memory arguments to memory */
        getOnePlusSecondNumberMeme(numbers);

    }

    function getOnePlusSecondNumber(uint[] calldata numbers) public pure returns(uint) {
        return numbers[1] + 1;
    }

}


contract FunkyStuff {

    function doFunkyStuff() external view {
        uint[] memory o = new uint[](2);
        
        // getOnePlusSecondNumber(o); //<-- NOT allowed 

        // The below methods makes an external call and is inefficient
        FunkyStuff(address(this)).getOnePlusSecondNumber(o); // <-- allowed
        this.getOnePlusSecondNumber(o); // <-- allowed
    }

    function getOnePlusSecondNumber(uint[] calldata numbers) public pure returns(uint) {
        return numbers[1] + 1;
    }

}