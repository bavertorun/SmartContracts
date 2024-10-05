# User Management Smart Contract

This smart contract allows an admin to manage user accounts. Admins can add or delete users and handle user balances, including deposits and withdrawals of Ether.

## Table of Contents

- [Features](#features)
- [Contract Structure](#contract-structure)
- [Functions](#functions)
- [Events](#events)
- [Usage](#usage)

## Features

- Admins can add new users with their full names.
- Admins can delete existing users.
- Users can deposit Ether into their account.
- Users can withdraw Ether from their account.
- Users can check their current balance.
- Events are emitted for user additions, deletions, and transactions.

## Contract Structure

    contract User {
        uint256[] private userIDs;
        uint256 private userIdCount;
        mapping(address => bool) private admins;
        mapping(address => uint256) private balances;

        constructor();
        modifier onlyAdmin;
        struct UserStruct { uint256 userID; string userFullName; address userAddress; }
        mapping(uint256 => UserStruct) public users;

        event UserAdded(uint256 indexed userID, string userFullName, address userAddress);
        event UserDeleted(uint256 indexed userID, string userFullName, address userAddress);
        event UserTransaction(address indexed userAddress, uint256 amount, Transaction transactionType);

        function addUser(string memory _fullname) public onlyAdmin;
        function deleteUser(uint256 _id) public onlyAdmin;
        function getUsers() public view returns(UserStruct[] memory);
        function deposit() public payable;
        function withdraw(uint256 _amount) public payable;
        function getBalance() public view returns(uint256);
    }

## Functions

### 1\. `constructor()`

Initializes the contract and sets the deployer as the first admin.

### 2\. `addUser(string memory _fullname)`

Allows the admin to add a new user by providing their full name. The user will be assigned a unique user ID.

### 3\. `deleteUser(uint256 _id)`

Allows the admin to delete a user by their unique user ID.

### 4\. `getUsers()`

Returns an array of all users currently registered in the contract.

### 5\. `deposit()`

Allows users to deposit Ether into their account. The deposited amount is added to their balance.

### 6\. `withdraw(uint256 _amount)`

Allows users to withdraw a specified amount of Ether from their account.

### 7\. `getBalance()`

Returns the current balance of the user calling the function.

## Events

- `UserAdded(uint256 indexed userID, string userFullName, address userAddress)` - Emitted when a new user is added.
- `UserDeleted(uint256 indexed userID, string userFullName, address userAddress)` - Emitted when a user is deleted.
- `UserTransaction(address indexed userAddress, uint256 amount, Transaction transactionType)` - Emitted for each deposit and withdrawal transaction.

## Usage

1.  Deploy the contract on an Ethereum network.
2.  The admin can call `addUser()` to add new users.
3.  The admin can call `deleteUser()` to remove users.
4.  Users can deposit Ether using the `deposit()` function.
5.  Users can withdraw Ether using the `withdraw(uint256 _amount)` function.
6.  Users can check their balance by calling the `getBalance()` function.
