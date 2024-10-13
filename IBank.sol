// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBank {
    function deposit() external payable;
    function withdraw(uint amount) external;
    function getbalance() external view returns (uint);
    function getTopDepositors() external view returns (address[3] memory, uint[3] memory);
}
