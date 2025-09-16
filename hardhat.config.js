require("@nomiclabs/hardhat-ethers");

module.exports = {
  solidity: "0.8.20",
  networks: {
    monadTestnet: {
      url: process.env.MONAD_RPC_URL || "https://testnet-rpc.monad.xyz",
      accounts: [process.env.PRIVATE_KEY]
    }
  }
};
require("dotenv").config();
require("@nomiclabs/hardhat-ethers");

module.exports = {
  solidity: "0.8.20",
  networks: {
    monadTestnet: {
      url: process.env.MONAD_RPC_URL,
      accounts: [process.env.PRIVATE_KEY] // Make sure PRIVATE_KEY is set and is a string!
    }
  }
};
