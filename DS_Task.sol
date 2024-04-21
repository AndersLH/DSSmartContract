// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract LeToken {
    string public name = "Le Coin";
    string public symbol = "LC";
    mapping(address => uint256) public balances;

    address public owner; 
    address payable public ownerPay;
    uint256 public totalCoins = 1000;

    event BuyLeCoin(
        address indexed _buyer,
        uint256 _amount
    );

    event TransferReward(
        address indexed _to,
        uint256 _amount
    );

    //Set owner and supply all Le Coins for distribution to people later
    constructor() {
        balances[msg.sender] = totalCoins;
        totalCoins = 0;
        owner = msg.sender;
        ownerPay = payable(msg.sender);
    }

    //Only owner modifier
    modifier onlyOwner(){
        require(owner == msg.sender, "You have to be owner to access");
        _;
    }

    //Owner function to transfer Le Coin
    function transferCoin(address _from, address _to, uint256 _amount) public onlyOwner {
        require(balances[_from] >= _amount,"Insufficient coins in the from address");
        balances[_from] -= _amount;
        balances[_to] += _amount;
    }

    //Check your own balance of Le Coin
    function myBalance() public view returns(uint256){
        return balances[msg.sender];
    }

    //Holds Le Coin in the 'totalCoins' variable
    function holdCoin(address _from, uint256 _amount) public {
        require(balances[_from] >= _amount,"Insufficient coins for reward");
        balances[_from] -= _amount;
        totalCoins += _amount;
    }

    //Transfer Le Coin from owmner to given address
    function transferRewardToAddress(address _to, uint256 _amount) public {
        totalCoins -= _amount;
        balances[_to] += _amount;
        emit TransferReward(_to, _amount);
    } 

    //Just for fun, you can spend 1 Ether on 100 Le Coins (more to show something being payable)
    //In theory, a mean older sibling could buy more Le Coin with real money to give their younger siblings more tasks hehe >:)
    function buyCoin() public payable {
        require(msg.value == 1 ether, "Need 1 ether to buy 100 Le Coin");
        balances[msg.sender] += 100;
        ownerPay.transfer(msg.value);

        emit BuyLeCoin(msg.sender, msg.value);
    }
}

contract TaskManagement {

    uint256 id;
    address leTokenAddress;

    enum Status {
        Available,
        InProgress,
        PendingDone,
        Done
    }

    struct Task {
        string name;
        string description;
        Status status;
        uint256 reward;
        address author;
        address assigned;
    }

    constructor(address _leTokenAddress){
        leTokenAddress = _leTokenAddress;
    }

    event ClaimedTask(
        address indexed _author,
        address indexed _assigned,
        uint256 _taskid
    );

    event CancelledTask(
        address indexed _author,
        address indexed _assigned,
        uint256 _taskid
    );

    event PendingTask(
        address indexed _author,
        address indexed _assigned,
        uint256 _taskid
    );

    event DeniedTask(
        address indexed _author,
        address indexed _assigned,
        uint256 _taskid
    );

    event VerifiedTask(
        address indexed _author,
        address indexed _assigned,
        uint256 _taskid
    );

    //Store tasks in mapping, with task keys in an array for iteration purposes
    mapping(uint256 => Task) public tasks;
    uint256[] public taskKeys;

    //Modifier for author-only actions 
    modifier onlyTaskAuthor(uint256 _id) {
        require(msg.sender == tasks[_id].author, "Only the author of the task can call this function");
        _;
    }

    //Modifier for assigned-only actions, will also allow task author to call it 
    modifier onlyTaskAssigned(uint256 _id) {
        require(msg.sender == tasks[_id].assigned || msg.sender == tasks[_id].author, "Only the author or assigned person of the task can call this function");
        _;
    }

    //Create a new task
    function createTask(string memory _name, string memory _description, uint256 _reward) public {
        id++;
        Task memory newTask;
        newTask.name = _name;
        newTask.description = _description;
        newTask.status = Status.Available;
        newTask.reward = _reward;
        newTask.author = msg.sender; 
        tasks[id] = newTask;
        taskKeys.push(id);

        //Moves Le Coin from person to totalCoins as reservation to prevent author not delivering the coins on task finish
        LeToken leToken = LeToken(leTokenAddress);
        leToken.holdCoin(msg.sender, _reward);
    }

    //Fetch all available tasks
    function showAllAvailableTasks() public view returns (Task[] memory) {

        uint256 availableLength = 0;

        //Get amount of available tasks and create array
        /*
        Note:
        Two for loops makes slightly more expensive in terms of gas, but unsure if that is preffered or 
        if having an array with some empty elements is better due to less gas useage.
        I decided to go for two for loops, since it gave a cleaner output for the user. 
        The alternative is:
        Replace availableLength with taskKeys.length and remove the first for loop
        new Task[](availableLength); --> new Task[](taskKeys.length);

        This comment goes for all the functions with two for loops. 
        */ 
        for (uint256 i = 0; i < taskKeys.length; i++) {
            if(tasks[taskKeys[i]].status == Status.Available){
                availableLength++;
            }
        }
        Task[] memory availableTasks = new Task[](availableLength);
        
        //Iterate and fetch all available tasks
        uint256 avIndex = 0;
        for (uint256 i = 0; i < taskKeys.length; i++) {
            if(tasks[taskKeys[i]].status == Status.Available){
                availableTasks[avIndex] = tasks[taskKeys[i]];
                avIndex++;
            }
        }

        return availableTasks;
    }

    //Fetch all in progress tasks for author's tasks 
    function showAllInProgressTasks() public view returns (Task[] memory) {

        uint256 inLength = 0;

        //Get amount of available tasks and create array
        for (uint256 i = 0; i < taskKeys.length; i++) {
            if(tasks[taskKeys[i]].status == Status.InProgress && tasks[taskKeys[i]].author == msg.sender){
                inLength++;
            }
        }
        Task[] memory progressTasks = new Task[](inLength);
        
        //Iterate and fetch all available tasks
        uint256 inIndex = 0;
        for (uint256 i = 0; i < taskKeys.length; i++) {
            if(tasks[taskKeys[i]].status == Status.InProgress && tasks[taskKeys[i]].author == msg.sender){
                progressTasks[inIndex] = tasks[taskKeys[i]];
                inIndex++;
            }
        }

        return progressTasks;
    }

    //Show all tasks assigned to yourself
    function myCurrentTasks() public view returns (Task[] memory) {
        uint256 myLength = 0;

        //Get amount of available tasks and create array
        for (uint256 i = 0; i < taskKeys.length; i++) {
            if(tasks[taskKeys[i]].assigned == msg.sender && tasks[taskKeys[i]].status == Status.InProgress){
                myLength++;
            }
        }
        Task[] memory myTasks = new Task[](myLength);
        
        //Iterate and fetch all available tasks
        uint256 myIndex = 0;
        for (uint256 i = 0; i < taskKeys.length; i++) {
            if(tasks[taskKeys[i]].assigned == msg.sender){
                myTasks[myIndex] = tasks[taskKeys[i]];
                myIndex++;
            }
        }

        return myTasks;
    }

    //Claim an available task with task id
    function claimTask(uint256 _id) public {
        require(tasks[_id].author != msg.sender,"Cannot claim your own task");
        require(tasks[_id].status == Status.Available,"Task is not available");
        tasks[_id].status = Status.InProgress;
        tasks[_id].assigned = msg.sender;

        emit ClaimedTask(tasks[_id].author, tasks[_id].assigned, _id);
    }

    //Cancel task, set back to 'Available'
    function cancelTask(uint256 _id) public onlyTaskAssigned(_id) {
        require(tasks[_id].status == Status.InProgress,"Task is not in progress");
        tasks[_id].status = Status.Available;
        
        emit CancelledTask(tasks[_id].author, tasks[_id].assigned, _id);
    }

    //Finished task, set to 'PendingDone'
    function finishTask(uint256 _id) public onlyTaskAssigned(_id) {
        require(tasks[_id].status == Status.InProgress,"Task is not in progress");
        tasks[_id].status = Status.PendingDone;

        emit PendingTask(tasks[_id].author, tasks[_id].assigned, _id);
    }

    //Lets author decline pending done request, set back to 'InProgress'
    function declineFinishTask(uint256 _id) public onlyTaskAuthor(_id) {
        require(tasks[_id].status == Status.PendingDone,"Task is not set to done");
        tasks[_id].status = Status.InProgress;
        
        emit DeniedTask(tasks[_id].author, tasks[_id].assigned, _id);
    }

    //Lets author accept done request, set to 'Done'.
    function verifyFinishTask(uint256 _id) public onlyTaskAuthor(_id) {
        require(tasks[_id].status == Status.PendingDone,"Task is not set to done");
        tasks[_id].status = Status.Done;
        distributeReward(tasks[_id].assigned, tasks[_id].reward);   

        emit VerifiedTask(tasks[_id].author, tasks[_id].assigned, _id);
    }

    //Reward 'assigned' after task is done
    function distributeReward(address _assigned, uint256 _reward) internal {
        LeToken leToken = LeToken(leTokenAddress);
        leToken.transferRewardToAddress(_assigned, _reward);
    }

}
