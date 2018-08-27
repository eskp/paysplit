pragma solidity ^0.4.24;

// TODO IMPLEMENT A LIBRARY

// TODO PLEASE USE SAFEMATH

// TODO COMMENT ACCORDING TO SPEC
// https://solidity.readthedocs.io/en/v0.4.21/layout-of-source-files.html#comments

/// @title A contract to make it easy to split ether payments between friends
/// @author Simon KP
/// @notice 
contract PaySplit {

    struct Group {
        address[] friends;
        uint256 total;
        mapping(address => uint256) spent;
        mapping(address => uint256) owes;

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
        //require(group.spent[msg.sender] != address(0), "Account is not part of the group");
        group.total += _cost; // BAD MATH
        group.spent[msg.sender] += _cost; // BAD MATH
        group.perUserCost = group.total / group.friends.length;
        group.owes[msg.sender] = group.perUserCost;
        emit ExpenseCreated(_groupId, msg.sender, _cost);
    }

    function finaliseGroup (uint256 _groupId) public {
        Group storage group = groups[_groupId];
        group.finalised = true;
    }

    function payOwed (uint256 _groupId) public payable {
        Group storage group = groups[_groupId];
        group.total -= msg.value; // BAD MATH
        group.perUserCost = group.total / group.friends.length;
        msg.sender.transfer(msg.value - group.owes[msg.sender]);
        // if (group.spent[msg.sender] < group.perUserCost) {
        //     if ((msg.value - group.owes[msg.sender]) >= 0) {
                
        //     }
        // }

        // TODO ADD EVENT
    }

    function claimOwed (uint256 _groupId) public {
        Group storage group = groups[_groupId];
        if (group.spent[msg.sender] > group.perUserCost) {
            msg.sender.transfer(group.spent[msg.sender] - group.perUserCost);
        }
        // TODO ADD EVENT
    }

    function getGroupsCount() public view returns (uint) {
        return groups.length;
    }

    function getGroup(uint256 _groupId) public view returns (uint256, uint256, uint256, bool) {
        Group storage group = groups[_groupId];
        return (groups[_groupId].total, group.friends.length, groups[_groupId].perUserCost, groups[_groupId].finalised);
    }

    function getGroupFriends(uint256 _groupId) public view returns (address[]) {
        return (groups[_groupId].friends);
    }

    function getFriendOwes(uint256 _groupId, address _friend) public view returns (uint256) {
        return (groups[_groupId].owes[_friend]);
    }

}

