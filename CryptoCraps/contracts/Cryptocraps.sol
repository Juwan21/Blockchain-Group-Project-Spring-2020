pragma solidity ^0.4.24;

contract CryptoCraps{
	
	struct game{
		uint8 setPoint;
		uint8 rollResult;
		uint8 betAmount;
		uint numberOfRolls;
		bool gameResult;
		bool isBetSet;
	}

	mapping(address => game) private games;

	event newSetPoint(address bidder, uint8 setPoint);
	event newBetSet(address bidder, uint8 betAmount);
	event rollResult(address bidder, uint8 rollResult);
	event gameResult(address bidder, string gameResult);


    uint8 private randomizer;

	constructor() public{
		randomizer=5;
	}

	function isBetSet() public view returns(bool){
		return games[msg.sender].isBetSet;
	}
	
	function getSetPoint() public view returns(uint8){
	    require(games[msg.sender].isBetSet == true);
	    return games[msg.sender].setPoint;
	}
	function getGameResult() public view returns(bool){
	    return games[msg.sender].gameResult;
	}
	
	function sendPot() public payable{
	   address _reciever=msg.sender;
	    require(games[msg.sender].gameResult == true);
	    _reciever.transfer(games[msg.sender].betAmount);
	}
	
	function getPot() public payable{
	    address _reciever=msg.sender;
	    require(games[msg.sender].gameResult == false);
	    _reciever.transfer(games[msg.sender].betAmount);
	}

	function getNewbet(uint8 userInput) public returns(uint8){
		require(games[msg.sender].isBetSet == false);
		require(msg.sender.balance > userInput);
		games[msg.sender].numberOfRolls=0;
		games[msg.sender].isBetSet = true;
		games[msg.sender].setPoint = getrandom();
		games[msg.sender].betAmount=userInput;
		randomizer += getrandom();
		emit newSetPoint(msg.sender,games[msg.sender].setPoint);
		emit newBetSet(msg.sender,games[msg.sender].betAmount);
		return games[msg.sender].setPoint;
	}

	function getrandom() public view returns (uint8) {
       uint8 value= uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)))*uint256(msg.sender)%5+1);
       uint8 value1= uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)))%5+1);
       return value1+value;
   }

    function roll() public returns(bool){
    	require (games[msg.sender].isBetSet == true);
    	randomizer += getrandom();
    	if(games[msg.sender].setPoint == 7 || games[msg.sender].setPoint == 11){
    	    games[msg.sender].numberOfRolls = 0;
    	    games[msg.sender].isBetSet=false;
    	    games[msg.sender].gameResult=true;
    	    return true;
    	}
    	if(games[msg.sender].numberOfRolls >= 3){
    	    games[msg.sender].numberOfRolls = 0;
    	    games[msg.sender].isBetSet=false;
    		games[msg.sender].gameResult=false;
    		return false;
    	}
    	if(games[msg.sender].setPoint == 2 || games[msg.sender].setPoint==3 || games[msg.sender].setPoint==12){
		    games[msg.sender].numberOfRolls = 0;
		    games[msg.sender].isBetSet=false;
    		games[msg.sender].gameResult=false;
    		return false;
    		
    	}
    	games[msg.sender].rollResult = getrandom();
    	games[msg.sender].numberOfRolls = games[msg.sender].numberOfRolls + 1;
    	emit rollResult(msg.sender, games[msg.sender].rollResult);
    	if(games[msg.sender].rollResult == games[msg.sender].setPoint){
    		games[msg.sender].numberOfRolls = 0;
    		games[msg.sender].isBetSet=false;
    		games[msg.sender].gameResult=true;
    		return true;
    		
    	}
    	if(games[msg.sender].rollResult == 7 ){
    	   games[msg.sender].numberOfRolls = 0;
    	    games[msg.sender].isBetSet=false;
    		games[msg.sender].gameResult=true;
    		return false; 
    	}
    
    	games[msg.sender].numberOfRolls = games[msg.sender].numberOfRolls + 1;
    	roll();
    }
}
