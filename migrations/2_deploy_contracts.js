const PSCMBC = artifacts.require("pscmbc");

module.exports = function (deployer) {

  deployer.deploy(PSCMBC,web3.eth.getAccounts());
};
