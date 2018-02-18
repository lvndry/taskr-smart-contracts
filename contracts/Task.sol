/**
* Contract for tasks handling
*/
pragma solidity ^0.4.19;
pragma experimental ABIEncoderV2;

contract Taskr {

  struct Task {
    uint ID;
    address owner;
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

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  modifier isTasker() {
    require(work[msg.sender].ID != 0);
    _;
  }

  event TaskDone(uint ID, address by);

  function Taskr() {
    owner = msg.sender;
  }

  function addTask(uint id, bytes32 desc, bytes32[]tests) onlyOwner() {
      require(!exists(id));
      Task memory newTask = Task(id, owner, desc, tests, false);
      tasks.push(newTask);
  }

  function NewTasker(Task task) {
    work[msg.sender] = task;
    taskers.push(msg.sender);
  }

  function exists(uint id) returns (bool) {
    if(tasks.length == 0) return false;
    for(uint i = 0; i < tasks.length; i++) {
      if (tasks[i].ID == id)
        return  true;
    }
    return false;
  }

  function isDone() {
    Task storage f = work[msg.sender];
    f.done = true;
    uint id = f.ID;
    deleteATOST(id);
  }

  function deleteATOST(uint id) returns (bool) {
    for(uint i = 0; i < taskers.length; i++){
      if(work[taskers[i]].ID == id) {
        work[taskers[i]] = Task(0, 0x00, '', new bytes32[](0), false);
      }
    }
  }
}
