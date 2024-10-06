# SmartContractsHub

Welcome to the **SmartContractsHub** repository! This repository contains various smart contracts developed using Solidity for Ethereum-based applications.

## Contracts

### 1. [Lottery Contract](LotteryContract)

- **Description**: A decentralized lottery system that allows participants to enter by purchasing tickets with Ether. The owner can select a random winner who receives the entire contract balance.
- **Key Features**:
  - Participants can enter the lottery by sending Ether.
  - Random winner selection based on participant entries.
  - Events for tracking lottery entries and winner selection.

### 2. [User Management Contract](UserManagementContract)

- **Description**: A contract for managing user accounts with administrative features.
- **Key Features**:
  - Add, delete, and retrieve user information.
  - Admin-only functions to maintain security.
  - Event logging for user actions.

### 3. [Crowdfunding Platform](CrowdfundingPlatform)

- **Description**: A decentralized crowdfunding platform where users can create projects, contribute funds, withdraw amounts once the goal is met, or request refunds if the project fails.
- **Key Features**:
  - Project creators can launch new crowdfunding projects with specific goals and deadlines.
  - Contributors can send Ether to support the projects they believe in.
  - Project owners can withdraw funds if the project meets its funding goal.
  - Contributors can request refunds if the project fails to reach its goal by the deadline.
  - Individual contributions for each project are tracked.


## LICENSE

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
