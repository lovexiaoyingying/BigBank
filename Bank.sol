
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    address public owner;
    mapping(address => uint) public deposits;
    struct Depositer {
        address depositorAddress;
        uint depositAmount;
    }
    Depositer[3] public topDeposittors;

    event Deposit(address indexed sender, uint value);
    event Withdraw(address indexed receiver, uint value);

    modifier onlyOwner() {
        require(msg.sender == owner, "wwww");
        _;
    }

    constructor() {
        owner = msg.sender;
    }
    receive() external payable {
        deposits[msg.sender] += msg.value;
        updateTopDepositors(msg.sender);
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint amount) public onlyOwner {
        require(amount <= address(this).balance, "Insufficient");
        payable(owner).transfer(amount);
        emit Withdraw(owner, amount);
    }
    function getbalance() public view returns (uint) {
        return address(this).balance;
    }
    function updateTopDepositors(address user) internal {
        uint userDeposit = deposits[user];

        for (uint i = 0; i < 3; i++) {
            if (topDeposittors[i].depositorAddress == user) {
                topDeposittors[i].depositAmount = userDeposit;
                sortTopDepositers();
                return;
            }
        }

        if(userDeposit > topDeposittors[2].depositAmount){
            topDeposittors[2] = Depositer(user, userDeposit);
            sortTopDepositers();
            return;

        }
    }

    function sortTopDepositers () internal {
        for (uint i = 0; i < 3; i++){
          for(uint j = i + 1; j < 3; j++){
             if(topDeposittors[j].depositAmount > topDeposittors[i].depositAmount){
                Depositer memory temp = topDeposittors[i];
                topDeposittors[i] = topDeposittors[j];
                topDeposittors[j] = temp;
             }
          }
        }
    }
    function getTopDepositors () public view returns( address[3] memory ,uint[3] memory){
       address[3] memory addresses;
       uint[3] memory amounts;
       for( uint i =0; i < 3; i++){
         addresses[i] = topDeposittors[i].depositorAddress;
         amounts[i] = topDeposittors[i].depositAmount;
       } 
       return (addresses , amounts );
    }
}
