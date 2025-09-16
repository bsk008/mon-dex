const hre = require("hardhat");

async function main() {
  // Monad USDC and USDT token addresses (Testnet)
const token1 = "0xf817257fed379853cDe0fa4F97AB987181B1E5Ea"; // USDC (checksum format)
const token2 = "0x88b8E2161DEDC77EF4ab7585569D2415a1C1055D"; // USDT (checksum format)


  const MyDEX = await hre.ethers.getContractFactory("MyDEX");
  const dex = await MyDEX.deploy(token1, token2);
  await dex.deployed();

  console.log("MyDEX deployed to:", dex.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
