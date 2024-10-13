// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Bank.sol"; // 假设 Bank 合约在同一个文件夹下

contract BigBank is Bank {
    address public newOwner;

    modifier minimumDeposit() {
        require(msg.value > 0.001 ether, "Deposit must be greater than 0.001 ether");
        _;
    }

    function deposit() external payable minimumDeposit {
        deposits[msg.sender] += msg.value;
        updateTopDepositors(msg.sender);
        emit Deposit(msg.sender, msg.value);
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        newOwner = _newOwner;
        owner = newOwner;
    }

    // function acceptOwnership() public {
    //     require(msg.sender == newOwner, "You must be the new owner to accept ownership");
    //     owner = newOwner;
    //     newOwner = address(0);
    // }
}
