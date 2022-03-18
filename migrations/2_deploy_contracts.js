const PaymentProcessor = artifacts.require('PaymentProcessor.sol');
const PSCMBC = artifacts.require('PSCMBC.sol');


/*module.exports = async function (deployer, network,addresses) {
    //const [payer,seller,_] = addresses;
    const accounts = await web3.eth.getAccounts();
    if(network === 'develop'){
        const p = await deployer.deploy(PaymentProcessor);
        

    } 
  
};*/

module.exports = async function (deployer,addresses) {

    await deployer.deploy(PSCMBC,web3.eth.getAccounts());
    const [payer,seller,_] = addresses
    await deployer.deploy(PaymentProcessor,web3.utils.toWei('10000'));
        

    
  
};