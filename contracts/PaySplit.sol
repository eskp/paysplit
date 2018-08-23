pragma solidity ^0.4.24;

// TODO IMPLEMENT A LIBRARY

// TODO PLEASE USE SAFEMATH

// TODO COMMENT ACCORDING TO SPEC
// https://solidity.readthedocs.io/en/v0.4.21/layout-of-source-files.html#comments

contract PaySplit {

    struct Group {
        address[] friends;
        uint256 total;
        mapping(address => uint256) spent;

        bool finalised;
        uint256 perUserCost;
    }

    Group[] groups;

    event GroupCreated(uint256 groupId);
    event ExpenseCreated(uint256 groupId, address sender, uint256 cost);

    // TODO Add more events

    function addGroup (address[] _friends) public {
        Group memory newGroup = Group(_friends, 0, false, 0);
        groups.push(newGroup);
        emit GroupCreated(groups.length - 1);
    }

    function addExpense (uint256 _groupId, uint256 _cost) public {
        // msg.sender is the person who incurred the expense
        require(!group.finalised, "This group is all payed up");
        Group storage group = groups[_groupId];
        group.total += _cost; // BAD MATH
        group.spent[msg.sender] += _cost; // BAD MATH
        emit ExpenseCreated(_groupId, msg.sender, _cost);
    }

    function finaliseGroup (uint256 _groupId) public {
        Group storage group = groups[_groupId];
        group.perUserCost = group.total / group.friends.length;
        group.finalised = true;
    }

    function payOwed (uint256 _groupId) public payable {
        Group storage group = groups[_groupId];
        if (group.spent[msg.sender] < group.perUserCost) {
            uint256 owes = group.perUserCost - group.spent[msg.sender];
            if ((msg.value - owes) > 0) {
                msg.sender.transfer(msg.value - owes);
            }
        }
    }

    function claimOwed (uint256 _groupId) public {
        Group storage group = groups[_groupId];
        if (group.spent[msg.sender] > group.perUserCost) {
            msg.sender.transfer(group.spent[msg.sender] - group.perUserCost);
        }
    }

}

