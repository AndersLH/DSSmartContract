/* eslint-disable no-undef */
// Right click on the script name and hit "Run" to execute
const { expect, assert} = require("chai");
const { ethers } = require("hardhat");

let LeToken;
let leToken;

let accounts;
let deployer;
let account1;
let account2;

before(async () => {
    //Deploy LeToken contract
    LeToken = await ethers.getContractFactory("LeToken");
    leToken = await LeToken.deploy();
    leToken.deployed();

    //Deploy TaskManagement contract
    // const Task = await ethers.getContractFactory("TaskManagement");
    // const task = await Task.deploy();
    // await task.deployed();

    // Get accounts
    accounts = await ethers.getSigners();
    deployer = accounts[0];
    account1 = accounts[1];
    account2 = accounts[2];
});

describe("LeToken", function () {

    it("Test constructor transferring Le Coin to deployer", async function () {

    assert.equal(await leToken.totalCoins(), 0, "totalCoins should be 0 as constructor transfer to deployer");
    assert.equal(await leToken.balances(await deployer.getAddress()), 1000, "deployer should be 1000 as constructor transfer to deployer");

    });

    it("Should transfer coins from one account to another", async () => {

    // Transfer coins
    await leToken.transferCoin(await deployer.getAddress(), await account1.getAddress(), 100);

    // Check updated balances
    const account1Balance = await leToken.balances(await account1.getAddress());

    // Assert balance changes
    assert.equal(account1Balance, 100, "account1 balance should be 100");
    });

    it("Should buy 100 Le Coin with 1 Ether", async () => {

    //Spend 1 Ether on buyCoin()
    await leToken.buyCoin({value: ethers.utils.parseEther("1")});

    // Check updated balances
    const deployerBalance = await leToken.balances(await deployer.getAddress());

    // Assert balance changes
    assert.equal(deployerBalance, 1000, "deployer balance should be back to 1000 after buying 100 Le Coin");
    });

    it("Should fail as there is not enough Le Coin to put in contract", async () => {
    //Try put more than 1000 Le Coin to contract
    await expect(leToken.holdCoin(await deployer.getAddress(), 1100)).to.be.reverted;
    });
});


// describe("TaskManagement", function () {
//   it("Test creating a new task", async function () {

//     //Create new task
//     await task.createTask("New task name","New task description",50);
    
//     // function createTask(string memory _name, string memory _description, uint256 _reward) public {


//     // assert.equal(await leToken.totalCoins(), 0, "totalCoins should be 0 as constructor transfer to deployer");
//     // assert.equal(await leToken.balances(await deployer.getAddress()), 1000, "deployer should be 1000 as constructor transfer to deployer");

//   });
// });
