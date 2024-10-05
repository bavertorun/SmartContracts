// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Lottery {
    address public owner;
    address[] public participants;
    uint256 public lotteryId;
    uint256 public immutable ticketPrice;

    event LotteryEntered(address indexed participants);
    event SelectedWinner(address indexed winner, uint256 amount);

    constructor() {
        owner = msg.sender;
        lotteryId = 0;
        ticketPrice = 1 ether;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can use this function!");
        _;
    }

    function enter() public payable {
        require(
            msg.value == ticketPrice,
            "Insufficient funds, ticket price is 1 ether."
        );
        participants.push(msg.sender);
        emit LotteryEntered(msg.sender);
    }

    function pickWinner() public onlyOwner {
        require(participants.length > 0, "There are no participants.");

        uint256 winnerIndex = random() % participants.length;
        address winner = participants[winnerIndex];

        payable(winner).transfer(address(this).balance);

        emit SelectedWinner(winner, address(this).balance);

        delete participants;
        lotteryId++;
    }

    function random() private view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(
                        block.prevrandao,
                        block.timestamp,
                        participants
                    )
                )
            );
    }

    function getParticipants() public view returns (address[] memory) {
        return participants;
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
