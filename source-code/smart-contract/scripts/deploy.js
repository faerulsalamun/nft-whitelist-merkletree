const hre = require('hardhat');

async function deploy(){
    const Salamun = await hre.ethers.getContractFactory('Salamun');
    const salamun = await Salamun.deploy();

    await salamun.deployed();

    console.log("Salamun deployed to:", salamun.address);
}

deploy()
    .then(() =>process.exit(0))
    .catch((error) =>{
        console.log(error)
        process.exit(1);
    });