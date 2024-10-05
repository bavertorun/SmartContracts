Lottery Smart Contract
======================

This is a simple lottery smart contract built using Solidity. It allows participants to enter the lottery by purchasing tickets, and the owner can pick a winner at the end of the lottery.

Table of Contents
-----------------

*   [Features](#features)
*   [Contract Structure](#contract-structure)
*   [Functions](#functions)
*   [Events](#events)
*   [Usage](#usage)

Features
--------

*   Participants can enter the lottery by paying a ticket price of 1 ether.
*   The contract owner can pick a random winner from the participants.
*   The winner receives the entire balance of the contract.
*   All participants' addresses are stored in an array.

Contract Structure
------------------

    contract Lottery {
        address public owner;
        address[] public participants;
        uint256 public lotteryId;
        uint256 public immutable ticketPrice;
        
        event LotteryEntered(address indexed participants);
        event SelectedWinner(address indexed winner, uint256 amount);
        
        constructor();
        modifier onlyOwner;
        function enter() public payable;
        function pickWinner() public onlyOwner;
        function random() private view returns(uint256);
        function getParticipants() public view returns(address[] memory);
        function getContractBalance() public view returns(uint256);
    }

Functions
---------

### 1\. \`constructor()\`

Initializes the contract, setting the owner to the address that deploys the contract and setting the ticket price to 1 ether.

### 2\. \`enter()\`

Allows participants to enter the lottery by sending the exact ticket price (1 ether).

### 3\. \`pickWinner()\`

Called by the owner to select a random winner from the participants and transfer the contract's balance to the winner.

### 4\. \`random()\`

Generates a pseudo-random number based on the previous block's hash, the current timestamp, and the participants' addresses.

### 5\. \`getParticipants()\`

Returns the list of participants currently entered in the lottery.

### 6\. \`getContractBalance()\`

Returns the current balance of the contract.

Events
------

*   `LotteryEntered(address indexed participants)` - Emitted when a participant enters the lottery.
*   `SelectedWinner(address indexed winner, uint256 amount)` - Emitted when a winner is selected.

Usage
-----

1.  Deploy the contract on an Ethereum network.
2.  Participants can call the `enter()` function to buy a lottery ticket.
3.  The owner can call the `pickWinner()` function to select a winner.
