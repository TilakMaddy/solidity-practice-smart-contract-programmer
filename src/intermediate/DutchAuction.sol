// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/* In a Dutch Auction the seller sets the maximum price first and then
it decreases over time, incentivising the highest bidder to buy the item
soon. There is also an expiration time. */

// Let's use an NFT as the item that is being auctioned
import "lib/forge-std/src/interfaces/IERC721.sol";

contract DutchAuction {
    uint256 public immutable discountRate;
    uint256 public immutable nftId;
    uint256 public immutable startPrice;
    uint256 public immutable startTime;
    uint256 public immutable totalTime;
    IERC721 public immutable nftContract;
    address public immutable owner;

    constructor(uint256 _startPrice, uint256 _nftId, uint256 _discountRate, uint256 _totalTime, IERC721 _nftContract) {
        startPrice = _startPrice;
        nftId = _nftId;
        discountRate = _discountRate;
        startTime = block.timestamp;
        totalTime = _totalTime;
        nftContract = _nftContract;
        owner = msg.sender;

        require(startPrice > (totalTime * discountRate * startPrice / 100));
    }

    function getCurrentPrice() public view returns (uint256) {
        return startPrice - discountRate * (block.timestamp - startTime);
    }

    // MEV - I could hold the transaction until the refund becomes 0
    function buy() external payable {
        require(block.timestamp - startTime < totalTime, "auction expired");

        uint256 currentPrice = getCurrentPrice();
        require(msg.value >= currentPrice);

        uint256 refund = msg.value - currentPrice;
        nftContract.transferFrom(owner, msg.sender, nftId);

        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        }

        selfdestruct(payable(owner));
    }
}
