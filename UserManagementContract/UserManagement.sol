// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract UserManagement {
    uint256[] private userIDs;
    uint256 private userIdCount;

    mapping(address => bool) private admins;

    mapping(address => uint256) private balances;

    constructor() {
        admins[msg.sender] = true;
    }

    modifier onlyAdmin() {
        require(admins[msg.sender], "You're is not owner !");
        _;
    }

    struct UserStruct {
        uint256 userID;
        string userFullName;
        address userAddress;
    }

    enum Transaction {
        DEPOSIT,
        WITHDRAW
    }

    mapping(uint256 => UserStruct) public users;

    event UserAdded(
        uint256 indexed userID,
        string userFullName,
        address userAddress
    );
    event UserDeleted(
        uint256 indexed userID,
        string userFullName,
        address userAddress
    );
    event UserTransaction(
        address indexed userAddress,
        uint256 amount,
        Transaction transactionType
    );

    function addUser(string memory _fullname) public onlyAdmin {
        users[userIdCount] = UserStruct(userIdCount, _fullname, msg.sender);
        userIDs.push(userIdCount);

        emit UserAdded(userIdCount, _fullname, msg.sender);

        userIdCount++;
    }

    function deleteUser(uint256 _id) public onlyAdmin {
        require(users[_id].userAddress != address(0), "User is not found!");

        emit UserDeleted(
            users[_id].userID,
            users[_id].userFullName,
            users[_id].userAddress
        );
        delete users[_id];
    }

    function getUsers() public view returns (UserStruct[] memory) {
        UserStruct[] memory allUsers = new UserStruct[](userIDs.length);

        for (uint256 i = 0; i < userIDs.length; i++) {
            allUsers[i] = users[userIDs[i]];
        }
        return allUsers;
    }

    function addAdmin(address _newAdmin) private onlyAdmin {
        require(!admins[_newAdmin], "This address is already an admin!");
        admins[_newAdmin] = true;
    }

    function deposit() public payable {
        require(msg.value > 0, "You need to send some ether");
        balances[msg.sender] += msg.value;

        emit UserTransaction(msg.sender, msg.value, Transaction.DEPOSIT);
    }

    function withdraw(uint256 _amount) public payable {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        payable(msg.sender).transfer(_amount);
        balances[msg.sender] -= _amount;

        emit UserTransaction(msg.sender, _amount, Transaction.WITHDRAW);
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
