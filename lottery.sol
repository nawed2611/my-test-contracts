// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract lottery {
    address owner;
    uint startTime;
    uint endTime;

    address[] allAddresses;

    constructor() {
        owner = msg.sender;
    }

    function startLottery(uint lotteryPeriod) public {
        require(
            msg.sender == owner,
            "Sorry, You don't have the access required"
        );

        startTime = block.timestamp;
        endTime = startTime + lotteryPeriod;
    }

    function buyTicket() public payable {
        require(block.timestamp <= endTime, "Time Period is over!!!");
        // Ticket cost here is 1 Ether
        require(msg.value == 1 ether, "Amount supplied is wrong");

        allAddresses.push(msg.sender);
    }

    function endLottery() public payable returns (bool) {
        require(
            msg.sender == owner,
            "Sorry, You don't have the access required"
        );
        require(block.timestamp > endTime, "Lottery is still going on");

        uint indexOfWinner = uint(
            keccak256(
                abi.encodePacked(block.timestamp, block.difficulty, msg.sender)
            )
        ) % allAddresses.length;
        address winner = allAddresses[indexOfWinner];

        (bool sent, ) = winner.call{value: address(this).balance}("");

        return sent;
    }
}
