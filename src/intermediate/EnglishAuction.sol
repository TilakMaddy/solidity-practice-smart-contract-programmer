// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/*In an English Auction the seller sets the starting price and an ending
time. The highest bidder gets to keep the item*/

import "lib/forge-std/src/interfaces/IERC721.sol";

contract EnglishAuction {
    // Item details
    IERC721 immutable nftAddress;
    uint256 immutable nftId;

    // Auction details
    uint256 immutable startPrice;
    uint256 immutable duration;
    uint256 immutable startTime;

    constructor(uint256 _startPrice, uint256 _duration, uint256 _nftAddress, uint256 _nftId) {
        startPrice = _startPrice;
        duration = _duration;
        startTime = block.timestamp;

        nftAddress = _nftAddress;
        nftId = _nftId;
    }
}
