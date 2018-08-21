var web3Provider = null;
var PaySplitContract;
const nullAddress = "0x0000000000000000000000000000000000000000";

function init() {
  // We init web3 so we have access to the blockchain
  initWeb3();
}

function initWeb3() {
  if (typeof web3 !== 'undefined') {
    web3Provider = web3.currentProvider;
  } else {    
    console.error('No web3 provider found. Please install Metamask on your browser.');
    //alert('No web3 provider found. Please install Metamask on your browser.');
    
    // set the provider you want from Web3.providers
    //web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
    web3Provider = new Web3.providers.HttpProvider('http://localhost:8545');

  }
  web3 = new Web3(web3Provider);
  
  // we init The Wrestling contract infos so we can interact with it
  initPaySplitContract();
}

function initPaySplitContract () {
    $.getJSON('PaySplit.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      PaySplitContract = TruffleContract(data);
  
      // Set the provider for our contract
      PaySplitContract.setProvider(web3Provider);
  
      // listen to the events emitted by our smart contract
      getEvents ();
  
      // We'll retrieve the Wrestlers addresses set in our contract using Web3.js
    //   getFirstWrestlerAddress();
    //   getSecondWrestlerAddress();
    });
  }

  function addGroup () {
    web3.eth.getAccounts(function(error, accounts) {
    if (error) {
      console.log(error);
    } else {
      if(accounts.length <= 0) {
        alert("No account is unlocked, please authorize an account on Metamask.")
      } else {
        PaySplitContract.deployed().then(function(instance) {
          return instance.addGroup([accounts[0]], {from: accounts[0]});
        }).then(function(result) {
          console.log('Created new group')
          //getSecondWrestlerAddress();
        }).catch(function(err) {
          console.log(err.message);
        });
      }
    }
    });
  }

  function getEvents () {
    PaySplitContract.deployed().then(function(instance) {
    var events = instance.allEvents(function(error, log){
      if (!error)
        $("#eventsList").prepend('<li>' + log.event + '</li>'); // Using JQuery, we will add new events to a list in our index.html
    });
    }).catch(function(err) {
      console.log(err.message);
    });
  }

  // When the page loads, this will call the init() function
// $(function() {
//     $(window).on('load', function() {
//       init();
//     });
// });
init();