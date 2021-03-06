const MatthewToken = artifacts.require("MatthewToken");

module.exports = function (deployer) {
  deployer.deploy(MatthewToken, "MatthewToken", "MJW", 1000000000000000000, 100000).catch(() => console.log("Deploy failed"));
};
