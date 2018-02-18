/**
* Contract for tasks handling
*/
pragma solidity ^0.4.19;
pragma experimental ABIEncoderV2;

contract Taskr {

  struct Task {
    uint ID;
    address owner;
    uint reward;
    bytes32 description;
    bytes32[] tests;
    bool done;
  }

  // Owner of the contract
  address public owner;

  // All the tasks of the owner of the contract
  Task[] tasks;

  //All the taskers
  address[] taskers;

  // Map all the taskers on the project and they if a tasker a finished
  mapping(address => Task) work;

  // The one who made the taksk first
  address win;

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  modifier isTasker() {
    require(work[msg.sender].ID != 0);
    _;
  }

  event TaskDone(Task done, address by);

  function Taskr() public {
    owner = msg.sender;
  }

  function addTask(uint id, bytes32 desc, bytes32[]tests, uint reward) public onlyOwner(){
      require(!exists(id));
      Task memory newTask = Task(id, owner, reward, desc, tests, false);
      tasks.push(newTask);
  }

  function NewTasker(uint id) public {
    Task memory t = getTask(id);
    work[msg.sender] = t;
    taskers.push(msg.sender);
  }

  function exists(uint id) public view returns (bool) {
    if(tasks.length == 0) return false;
    for(uint i = 0; i < tasks.length; i++) {
      if (tasks[i].ID == id)
        return  true;
    }
    return false;
  }

  function isDone() public {
    Task storage f = work[msg.sender];
    f.done = true;
    uint id = f.ID;
    win = msg.sender;
    deleteATOST(id);
  }

  function deleteATOST(uint id) public returns (bool) {
    for(uint i = 0; i < taskers.length; i++) {
      if(work[taskers[i]].ID == id) {
        TaskDone(work[taskers[i]], win);
        delete work[taskers[i]];
      }
    }
  }

  function getTask(uint id) public view returns(Task) {
    for(uint i = 0; i < tasks.length; i++) {
      if(tasks[i].ID == id) {
        return tasks[i];
      }
    }
  }
}
