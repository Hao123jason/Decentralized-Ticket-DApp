// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TicketSystem {
    struct Activity {
        string name;
        uint256 originPrice;
        uint256 totalTickets;
        uint256 soldCount;
        address organizer;
    }
    
    uint256 public activityCount;
    mapping(uint256 => Activity) public activities;

    // 建立活動
    function createActivity(string memory _name, uint256 _price, uint256 _totalTickets) public {
        activityCount++;
        activities[activityCount] = Activity(_name, _price, _totalTickets, 0, msg.sender);
    }

    // 買一手票
    function buyTicket(uint256 _activityId) public payable {
        Activity storage act = activities[_activityId];
        require(act.totalTickets > act.soldCount, "Sold out!");
        require(msg.value == act.originPrice, "Incorrect ETH!");

        act.soldCount++;
        payable(act.organizer).transfer(msg.value); // 把錢轉給主辦方
    }
}
