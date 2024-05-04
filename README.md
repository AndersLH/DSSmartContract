# Le Coin, IMT4306 project

## Description
This is a project using smart contracts for a decentralized autonomous organization (DAO). 
The project consists of two contracts:
### LeToken
The 'LeToken' contract represents a custom cryptocurrency called 'Le Coin' (LC). It initially creates and gives 1000 LC to the deployer of the contract. It keeps track of everyone's balance of LC, lets the deployer transfer LC between people, and is the middle ground for distributing rewards after completing tasks. It is also possible to buy more LC using Ethereum, although this is more of a proof-of-concept of payable functions than an actual useful function. 
### TaskManagement
The 'TaskManagement' contract is where all the task logic is placed. Some of the features in 'TaskManagement' include:
- Creating a new task with a name, description, and reward in LC for completing the task. 
- Viewing 'available' tasks, your own 'in progress' tasks, and 'in progress' tasks you authored.
- Cancel tasks
- Finish tasks, that wait for author approval or decline.
- Automatically hand out rewards after a finished task is approved.

## Deploy and run using Remix 
1. Open Remix (https://remix.ethereum.org/) and upload 'DS_Task.sol' to the IDE.
2. Compile the 'DS_Task.sol' file. 
3. Choose the 'LeToken' contract in the 'Contract' list and press 'Deploy'
4. Go down to 'Deployed/Unpinned Contracts' and copy the address of the newly deployed 'LeToken' contract.
5. Choose the 'TaskManagement' contract in the 'Contract' list, paste the 'LeToken' address into the input, and press 'Deploy'
6. Interact with the contract under 'Deployed/Unpinned Contracts'

## Running the tests using Remix
1. Upload 'DS_Task_test.js' to the Remix IDE
2. Run the script.
   - The script can be run by pressing the green play button in the top left or right-clicking the file in the file explorer and pressing 'run'.

## How to use and interact with the contracts

