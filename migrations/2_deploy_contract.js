var Taskr = artifacts.require("./Taskr.sol");

module.exports = function(deployer) {
  deployer.deploy(Taskr);
};
