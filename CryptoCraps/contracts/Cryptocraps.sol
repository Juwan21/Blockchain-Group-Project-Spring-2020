pragma solidity ^0.4.24;

contract cryptocraps{
	
	struct game{
		uint8 setPoint;
		uint8 rollResult;
		uint8 betAmount;
		uint numberOfRolls;
		bool gameResult;
		bool isBetSet;
	    string name;
	}

	mapping(address => game) private games;

	event newSetPoint(address bidder, uint8 setPoint);
	event newBetSet(address bidder, uint8 betAmount);
	event rollResult(address bidder, uint8 rollResult);
	event gameResult(address bidder, bool gameResult);


    uint8 private randomizer;

	constructor() public{
		randomizer=5;

	}
	
	function getName() view returns(string){
		return games[msg.sender].name;
	}
	
	function setName(string _name) public {
		games[msg.sender].name = _name;
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
	
	function sendPayment() public payable{
	   address _reciever=msg.sender;
	    require(games[msg.sender].gameResult == true);
	    _reciever.transfer(games[msg.sender].betAmount);
	}
	
	function recievePayment() public payable{
	    address _reciever=msg.sender;
	    require(games[msg.sender].gameResult == false);
	    _reciever.transfer(games[msg.sender].betAmount);
	}

	function getNewBet(uint8 userInput) public{
		require(games[msg.sender].isBetSet == false);
		require(msg.sender.balance > userInput);
		games[msg.sender].numberOfRolls=0;
		games[msg.sender].isBetSet = true;
		
		games[msg.sender].betAmount=userInput;
		randomizer += getRandom();
		
		emit newBetSet(msg.sender,games[msg.sender].betAmount);
		
	}
    function setThePoint() public returns(uint8){
		require(games[msg.sender].setPoint == 0);
        games[msg.sender].setPoint = getRandom();
        emit newSetPoint(msg.sender,games[msg.sender].setPoint);
        return games[msg.sender].setPoint;
    }
	function getRandom() public view returns (uint8) {
       uint8 value= uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)))*uint256(msg.sender)%5+1);
       uint8 value1= uint8(uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty)))%5+1);
       return value1+value;
   }

    function roll() public returns(bool){
    	require (games[msg.sender].isBetSet == true);
    	randomizer += getRandom();
    	if(games[msg.sender].setPoint == 7 || games[msg.sender].setPoint == 11){
    	    games[msg.sender].numberOfRolls = 0;
    	    games[msg.sender].isBetSet=false;
    	    games[msg.sender].gameResult=true;
			games[msg.sender].setPoint=0;
    	    return true;
    	}
    	if(games[msg.sender].numberOfRolls >= 3){
    	    games[msg.sender].numberOfRolls = 0;
    	    games[msg.sender].isBetSet=false;
    		games[msg.sender].gameResult=false;
			games[msg.sender].setPoint=0;
    		return false;
    	}
    	if(games[msg.sender].setPoint == 2 || games[msg.sender].setPoint==3 || games[msg.sender].setPoint==12){
		    games[msg.sender].numberOfRolls = 0;
		    games[msg.sender].isBetSet=false;
    		games[msg.sender].gameResult=false;
			games[msg.sender].setPoint=0;
    		return false;
    		
    	}
    	games[msg.sender].rollResult = getRandom();
    	games[msg.sender].numberOfRolls = games[msg.sender].numberOfRolls + 1;
    	emit rollResult(msg.sender, games[msg.sender].rollResult);
    	if(games[msg.sender].rollResult == games[msg.sender].setPoint){
    		games[msg.sender].numberOfRolls = 0;
    		games[msg.sender].isBetSet=false;
    		games[msg.sender].gameResult=true;
			games[msg.sender].setPoint=0;
    		return true;
    		
    	}
    	if(games[msg.sender].rollResult == 7 ){
    	   games[msg.sender].numberOfRolls = 0;
    	    games[msg.sender].isBetSet=false;
    		games[msg.sender].gameResult=true;
			games[msg.sender].setPoint=0;
    		return false; 
    	}
    
    	games[msg.sender].numberOfRolls = games[msg.sender].numberOfRolls + 1;
    	roll();
    }
}
