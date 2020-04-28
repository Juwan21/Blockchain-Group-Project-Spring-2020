const cryptocraps = artifacts.require("cryptocraps");

module.exports = function(deployer) {
  deployer.deploy(cryptocraps);
};