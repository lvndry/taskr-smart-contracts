var Taskr = artifacts.require("./Task.sol");

module.exports = function(deployer) {
  deployer.deploy(Taskr);
};
