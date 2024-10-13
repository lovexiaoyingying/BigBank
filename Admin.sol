

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IBank.sol";

contract Admin {
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // 从指定的 IBank 合约中提取资金
    function adminWithdraw(IBank bank, uint amount) public onlyOwner {
        // 调用 IBank 接口的 withdraw 函数从 Bank 合约中提取资金
        bank.withdraw(amount);

        // 将提取的资金转移到 Admin 合约地址
        payable(address(this)).transfer(amount);
    }

    // 获取 Admin 合约的余额
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // 接收转账的回退函数
    receive() external payable {}
}
