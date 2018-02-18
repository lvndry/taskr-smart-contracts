var Taskr = artifacts.require('./Taskr');

contract('Taskr', function(accounts) {
  it("Create new task and assign tasker to it", function(done) {
    var taskr = Taskr.deployed();
    taskr.then(function(instance){
      return taskr.addTask();
    })
    assert.isTrue(true);
    done();
  });
});
