# DSSmartContract

## Description
This is a project using smart contracts for a Decentralized Autonomous Organisation (DAO). 
The project consists of two contracts:
### LeToken
The 'LeToken' contract represents a custom cryptocurrency called 'Le Coin' (LC). It initially creates and gives 1000 LC to the deployer of the contract. It keeps track of everyone's balance of LC, lets the deployer transfer LC between people and is the middle ground for distributing rewards after completing tasks. It is also possible to buy more LC using Ethereum, although this is more of a proof-of-concept of payable functions, rather than an actul useful function.    
### TaskManagement
The 'TaskManagement' contract is where all the task logic is placed. Some of the features in 'TaskManagement' includes:
- Creating a new task, with a name, description and a reward in LC for completing the task. 
- Viewing 'avaiable' tasks, your own 'in progress' tasks and 'in progress' tasks you authored.
- Cancel tasks
- Finish tasks, which waits for author approval or decline
- Automatically hand out reward after a finished task is approved

## Deploy and run using Remix 
1. Open Remix (https://remix.ethereum.org/) and upload 'DS_Task.sol' to the IDE.
2. Compile the 'DS_Task.sol' file 
3. Choose the 'LeToken' contract in the 'Contract' list and press 'Deploy'
4. Go down to 'Deployed/Unpinned Contracts' and copy the address of the newly deployed 'LeToken' contract
5. Choose the 'TaskManagement' contract in the 'Contract' list, paste the 'LeToken' address into the input and press 'Deploy'
6. Interact with the contract under 'Deployed/Unpinned Contracts'

## Running the tests using Remix
1. Upload 'DS_Task_test.js' to the Remix IDE
2. 



Objective
The objective of this assignment is to provide students with the opportunity to design, specify, and
implement smart contracts for a Decentralized Autonomous Organisation (DAO) based on real-world
scenarios. Students will choose one of the provided project ideas or propose their own and develop a
comprehensive specification document along with functional smart contracts to demonstrate the
functionality of the DAO.
Instructions
1. Project Selection: Choose one of the provided project ideas or propose your own idea
related to the design and implementation of a DAO. Ensure that the project idea involves the
use of smart contracts to automate processes within the DAO.
2. Specification Document: Develop a detailed specification document outlining the following
aspects of your DAO project:
•
o Overview of the DAO's purpose, goals, and target audience.
o Description of the proposed functionalities and features of the DAO.
o User roles and permissions within the DAO.
o Detailed specifications of smart contracts to be developed, including their functions,
inputs, outputs, and interactions with other contracts.
o Description of the DAO's governance model, including voting mechanisms and
decision-making processes.
o Consideration of security measures, including potential vulnerabilities and mitigation
strategies.
3. Smart Contract Implementation: Based on the specifications outlined in the document, implement
functional smart contracts using a suitable blockchain development platform (e.g., Ethereum, Binance
Smart Chain). Ensure that the smart contracts adhere to best practices for security, efficiency, and
readability.
4. Testing and Deployment: Test the implemented smart contracts thoroughly to ensure their
correctness and reliability. Deploy the smart contracts to a testnet network and provide instructions for
accessing and interacting with them.
5. Documentation: Prepare the documentation for your DAO project, including:
•
o Specification for the DAO objectives, core ideas, and all necessary assumptions.
o Technical documentation describing the architecture, design decisions, and
implementation details of the smart contracts.
o User documentation explaining how to use the DAO platform, interact with smart
contracts, and participate in governance processes.
o Deployment instructions for deploying the smart contracts to a blockchain network.
Deliverables
1. Specification Document (as a PDF report): A well-written specification document outlining
the design and functionality of the DAO project.
2. Code including Smart Contracts (in the GIT repo): Functional smart contracts implemented
according to the specifications provided in the document.
3. Documentation (inside the GIT repo, or as part of the PDF report): Comprehensive
documentation covering technical details, user instructions, and deployment guidelines for the
DAO project.
Evaluation Criteria:
• Clarity and completeness of the specification document.
• Correctness and efficiency of the implemented smart contracts.
• Adherence to best practices for smart contract development and blockchain security.
• Quality and comprehensiveness of the documentation.
• Overall creativity, innovation, and relevance of the DAO project idea.
Project ideas. Pick one from the list below or propose your own.
• Decentralized Task Management System: Develop a DAO-based task management system
where users can create tasks, assign them to others, and receive payments automatically
upon completion. Utilize smart contracts to manage task creation, assignment, verification,
and payment distribution
