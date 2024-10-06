Crowdfunding Platform Smart Contract
====================================

This smart contract implements a decentralized crowdfunding platform, where users can create projects, contribute funds, withdraw raised amounts if the project goal is met, or request refunds if the project fails.

Table of Contents
-----------------

*   [Features](#features)
*   [Contract Structure](#contract-structure)
*   [Functions](#functions)
*   [Events](#events)
*   [Usage](#usage)

Features
--------

*   Project creators can start a new crowdfunding project with a title, description, goal, and duration.
*   Contributors can send Ether to projects they support.
*   Project owners can withdraw the total amount raised once the funding goal is reached.
*   Contributors can request a refund if the project fails to reach its goal by the deadline.
*   Individual contributions for each project are tracked.

Contract Structure
------------------

    
    contract CrowdfundingPlatform {
        struct Project {
            address payable owner;
            string title;
            string description;
            uint256 goal;
            uint256 deadline;
            uint256 amountRaised;
            bool completed;
            mapping(address => uint256) contributions;
        }
    
        Project[] public projects;
    
        function createProject(string memory _title, string memory _description, uint256 _goal, uint256 _duration) public;
        function contribute(uint256 _projectId) public payable;
        function withdrawFunds(uint256 _projectId) public;
        function refund(uint256 _projectId) public;
        function getProjectDetails(uint256 _projectId) public view returns (address, string memory, string memory, uint256, uint256, uint256, bool);
        function getContribution(uint256 _projectId, address _contributor) public view returns (uint256);
    }
    

Functions
---------

### 1\. `createProject(string memory _title, string memory _description, uint256 _goal, uint256 _duration)`

Allows a user to create a new crowdfunding project with a specified title, description, funding goal, and duration. The project owner will be set as the user calling the function.

### 2\. `contribute(uint256 _projectId)`

Allows users to contribute Ether to a specific project. The contribution is tracked, and the total amount raised for the project is updated.

### 3\. `withdrawFunds(uint256 _projectId)`

Allows the project owner to withdraw funds once the project has reached its funding goal. The project must not have already been marked as completed.

### 4\. `refund(uint256 _projectId)`

Allows contributors to request a refund if the project's deadline has passed and it has not met its funding goal. The contributor receives the amount they contributed.

### 5\. `getProjectDetails(uint256 _projectId)`

Returns the details of a specific project, including the owner, title, description, goal, deadline, amount raised, and whether the project is completed.

### 6\. `getContribution(uint256 _projectId, address _contributor)`

Returns the amount a specific contributor has contributed to a project.

Usage
-----

1.  **Deploy the contract** on an Ethereum network.
2.  **Create a project** using the `createProject()` function, specifying the title, description, goal, and duration.
3.  **Contribute to a project** by calling `contribute()` and sending Ether to support a project.
4.  Once the funding goal is reached, the **project owner can withdraw the funds** using the `withdrawFunds()` function.
5.  If the project fails to reach its goal by the deadline, contributors can request a **refund** using the `refund()` function.
6.  Use `getProjectDetails()` to view details about a project, and `getContribution()` to check the contribution of a specific user.