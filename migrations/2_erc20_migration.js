const MatthewToken = artifacts.require("MatthewToken");

module.exports = function (deployer) {
  deployer.deploy(MatthewToken, "MatthewToken", "MJW", 18, 100000).catch(() => console.log("Deploy failed"));
};
