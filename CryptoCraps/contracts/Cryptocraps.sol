pragma solidity ^0.4.24;

contract CryptoCraps{
	
	struct games{
		uint8 setPoint;
		uint8 rollResult;
		uint8 betAmount;
		uint numberOfRolls;
		bool isBetSet;
	}

	mapping(address => games) private games;

	event newSetPoint(address bidder, uint8 setPoint);
	event newBetSet(address bidder, uint8 betAmount);
	event rollResult(address bidder, uint8 rollResult);


    uint8 private randomizer;

	constructor() public{
		randomizer=5;
	}

	function isBetSet() public view returns(bool){
		return games[msg.sender].isBetSet;
	}

	function getNewbet(userInput) public returns(uint8){
		require(games[msg.sender].isBetSet == false);
		games[msg.sender].isBetSet = true;
		//line below should probably be changed to allow user to select the number they wish to betting on.
		games[msg.sender].setPoint = random() ;
		//line below this is intended to set the new bet amount. not sure how to accept user input so this is currently not correct.
		games[msg.sender].betAmount=userInput;
		randomizer += random();
		emit NewBetSet(msg.sender,games[msg.sender].setPoint);
		emit newBetAmount(msq.sender,games[msg.sender].betAmount);
		return games[msg.sender].setPoint;
	}

	function random() private view returns (uint8) {
       	uint256 blockValue = uint256(blockhash(block.number-1 + block.timestamp));
        blockValue = blockValue + uint256(randomFactor);
        return uint8(blockValue % 5) + 1;
    }

    function roll(){
    	require (games[msg.sender].isBetSet == true);
    	randomizer += random();
    	if(games[msg.sender].numberOfRolls > 3){
    		return loser;
    	}
    	games[msg.sender].rollResult = random();
    	emit rollResult(msg.sender, games[msg.sender].rollResult);
    	if(games[msg.sender].rollResult == 7 || games[msg.sender].rollResult == games[msg.sender].setPoint){
    		games[msg.sender].numberOfRolls = 0;
    		return winner;
    	}
    	if(games[msg.sender].rollResult == 2 || games[msg.sender].rollResult==3 || games[msg.sender.rollResult==12]){
		    games[msg.sender].numberOfRolls = 0;
    		return loser;
    	}
    	else{
    		games[msg.sender].numberOfRolls = games[msg.sender].numberOfRolls + 1;
    		roll();
    	}pragma solidity ^0.4.24;

contract CryptoCraps{
	
	struct game{
		uint8 setPoint;
		uint8 rollResult;
		uint8 betAmount;
		uint numberOfRolls;
		string gameResult;
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

	function getNewbet(uint8 userInput) public returns(uint8){
		require(games[msg.sender].isBetSet == false);
		games[msg.sender].numberOfRolls=0;
		games[msg.sender].isBetSet = true;
		//line below should probably be changed to allow user to select the number they wish to betting on.
		games[msg.sender].setPoint = random() ;
		//line below this is intended to set the new bet amount. not sure how to accept user input so this is currently not correct.
		games[msg.sender].betAmount=userInput;
		randomizer += random();
		emit newSetPoint(msg.sender,games[msg.sender].setPoint);
		emit newBetSet(msg.sender,games[msg.sender].betAmount);
		return games[msg.sender].setPoint;
	}

	function random() private view returns (uint8) {
       	uint256 blockValue = uint256(blockhash(block.number-1 + block.timestamp));
        blockValue = blockValue + uint256(randomizer);
        return uint8(blockValue % 5) + 1;
    }

    function roll() public returns(bool){
    	require (games[msg.sender].isBetSet == true);
    	randomizer += random();
    	if(games[msg.sender].numberOfRolls > 3){
    		games[msg.sender].gameResult="Winner";
    		return false;
    	}
    	games[msg.sender].rollResult = random();
    	emit rollResult(msg.sender, games[msg.sender].rollResult);
    	if(games[msg.sender].rollResult == 7 || games[msg.sender].rollResult == games[msg.sender].setPoint){
    		games[msg.sender].numberOfRolls = 0;
    		games[msg.sender].isBetSet=false;
    		games[msg.sender].gameResult="Winner";
    		return true;
    		
    	}
    	if(games[msg.sender].rollResult == 2 || games[msg.sender].rollResult==3 || games[msg.sender].rollResult==12){
		    games[msg.sender].numberOfRolls = 0;
		    games[msg.sender].isBetSet=false;
    		games[msg.sender].gameResult="Winner";
    		return false;
    		
    	}
    	else{
    		games[msg.sender].numberOfRolls = games[msg.sender].numberOfRolls + 1;
    		roll();
    	}
    }
}
