const MatthewToken = artifacts.require("MatthewToken");

module.exports = function (deployer) {
  deployer.deploy(MatthewToken).catch(() => console.log("Deploy failed"));
};
