const PaySplit = artifacts.require("./PaySplit.sol");

module.exports = function(deployer) {
  deployer.deploy(PaySplit);
};
