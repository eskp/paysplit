pragma solidity 0.4.20;

// PLEASE USE SAFEMATH

contract PaySplit {

  Group[] groups;

  event GroupCreated(uint256 _groupId);

  struct Group {
    address[] friends;
    uint256 total;
    mapping(address => uint256) spent;

    bool finalised;
    uint256 perUserCost;
  }

  addGroup (address[] _friends) {
    Group memory newGroup = Group(_friends, 0);
    groups.push(newGroup);
    emit GroupCreated(groups.length - 1);
  }

  addExpense (uint256 _groupId, uint256 _cost) {
    // msg.sender is the person who incurred the expense
    require(!group.finalised);
    Group memory group = groups[_groupId];
    group.total += _cost; // BAD MATH
    group.spent[msg.sender] += _cost; // BAD MATH
  }

  finaliseGroup (uint256 _groupId) {
    Group memory group = groups[_groupId];
    group.perUserCost = group.total / group.length;
    group.finalised = true;
  }

  payOwed (uint256 _groupId) payable {
    Group memory group = groups[_groupId];
    if (group.spent[msg.sender] < group.perUserCost) {
      uint256 owes = group.perUserCost - group.spent[msg.sender];
      if ((msg.value - owes) > 0) {
        msg.sender.transfer(msg.value - owes);
      }
    }
  }

  claimOwed (uint256 _groupId) {
    Group memory group = groups[_groupId];
    if (group.spent[msg.sender] > group.perUserCost) {
      msg.sender.transfer(group.spent[msg.sender] - group.perUserCost);
    }
  }

}

