

App = {
  web3Provider: null,
  contracts: {},
  
  /*  init: function() {
    return App.initWeb3();
  },*/

  init: function() {
    // Load pets.
    $.getJSON('../cryptocraps.json', function(data) {
      
      })
    

    return App.initWeb3();
  },

  initWeb3: function() {
		if (window.ethereum) {
	  App.web3Provider = window.ethereum;
	  try {
		// Request account access
		 window.ethereum.enable();
	  } catch (error) {
		// User denied account access...
		console.error("User denied account access")
	  }
	}
	// Legacy dapp browsers...
	else if (window.web3) {
	  App.web3Provider = window.web3.currentProvider;
	}
	// If no injected web3 instance is detected, fall back to Ganache
	else {
	  App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
	}
	web3 = new Web3(App.web3Provider);
	web3.eth.defaultAccount = web3.eth.accounts[0];
    return App.initContract();
  },

  initContract: function() {
		$.getJSON('cryptocraps.json', function(cryptocraps) {
	  // Get the necessary contract artifact file and instantiate it with truffle-contract
	  var cryptoArtifact = cryptocraps;
	  App.contracts.cryptocraps = TruffleContract(cryptoArtifact);

	  // Set the provider for our contract
	  App.contracts.cryptocraps.setProvider(App.web3Provider);

	});

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', 'submitBtn', App.getNewBet());
	return App.render();
  },



  getNewBet: function(event) {
   
	var betAmount = event;
    //var betAmount = parseInt($(event.target).data('id'));
	//console.log(betAmount)
	web3.eth.getAccounts(function(error, accounts) {
	  if (error) {
		console.log(error);
	  } 
    })
	 App.contracts.cryptocraps.deployed().then(function(instance) {
    cryptoApp = instance;
	return cryptoApp.getNewBet(betAmount);
	 })
  
  }, 
};


