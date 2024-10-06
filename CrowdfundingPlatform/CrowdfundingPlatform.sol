// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

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

    // Create a new project
    function createProject(string memory _title, string memory _description, uint256 _goal, uint256 _duration) public {
        Project storage newProject = projects.push();

        newProject.owner = payable(msg.sender);  // Owner is payable to withdraw funds
        newProject.title = _title;
        newProject.description = _description;
        newProject.goal = _goal;
        newProject.deadline = block.timestamp + _duration;
        newProject.amountRaised = 0;
        newProject.completed = false;
    }

    // Contribute to a project
    function contribute(uint256 _projectId) public payable {
        Project storage project = projects[_projectId];
        require(block.timestamp < project.deadline, "Project deadline has passed.");
        require(msg.value > 0, "Contribution must be greater than 0.");
        
        // Update the contribution and total amount raised
        project.amountRaised += msg.value;
        project.contributions[msg.sender] += msg.value;
    }

    // Withdraw funds if the goal is reached
    function withdrawFunds(uint256 _projectId) public {
        Project storage project = projects[_projectId];
        require(msg.sender == project.owner, "Only project owner can withdraw funds.");
        require(project.amountRaised >= project.goal, "Project has not reached its goal.");
        require(!project.completed, "Funds already withdrawn.");
    
        project.completed = true;
        project.owner.transfer(project.amountRaised);
    }

    // Refund contributors if the goal is not met
    function refund(uint256 _projectId) public {
        Project storage project = projects[_projectId];
        require(block.timestamp > project.deadline, "Project is still ongoing.");
        require(project.amountRaised < project.goal, "Project has reached its goal.");

        uint256 contributedAmount = project.contributions[msg.sender];
        require(contributedAmount > 0, "You did not contribute to this project.");

        project.contributions[msg.sender] = 0;
        payable(msg.sender).transfer(contributedAmount);
    }

    // Get details of a specific project (without returning the contributions mapping)
    function getProjectDetails(uint256 _projectId) public view returns (
        address owner, 
        string memory title, 
        string memory description, 
        uint256 goal, 
        uint256 deadline, 
        uint256 amountRaised, 
        bool completed
    ) {
        Project storage project = projects[_projectId];
        return (
            project.owner,
            project.title,
            project.description,
            project.goal,
            project.deadline,
            project.amountRaised,
            project.completed
        );
    }

    // Get individual contributions for a project
    function getContribution(uint256 _projectId, address _contributor) public view returns (uint256) {
        Project storage project = projects[_projectId];
        return project.contributions[_contributor];
    }
}
