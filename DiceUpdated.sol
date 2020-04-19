pragma solidity ^0.4.24;

contract Dice{

	struct Bet{
		uint8  currentBet;
		bool  isBetSet; //default value is false	
		uint8  destiny;
		uint256 betAmount;
		//number of dice actually represents number of 'options' like if 20 is picked the roll will land between 1 and 20
		uint8 numberOfDice;
	}

	mapping(address => Bet) private bets;
	
	uint256 conversionRate=    ; //whatever conversion is right to send ether
	uint8 private randomFactor;

	event NewBetIsSet(address bidder , uint8 currentBet);

	event GameResult(address bidder, uint8 currentBet , uint8 destiny);
	
	// new event
	event newBetAmount(address bidder, uint256 betAmount);
	//new event 
	event newNumberOfDice(address bidder, uint8 numberOfDice);

	constructor() public{
		randomFactor = 10;
	}

	function isBetSet() public view returns(bool){
		return bets[msg.sender].isBetSet;
	}

	function getNewbet() public returns(uint8){
		require(bets[msg.sender].isBetSet == false);
		bets[msg.sender].isBetSet = true;
		//line below should probably be changed to allow user to select the number they wish to bet on.
		bets[msg.sender].currentBet = random();
		//line below this is intended to set the new bet amount. Not sure how to accept user input so this is currently not correct.
		bets[msg.sender].newBetAmount=newBetAmount;
		randomFactor += bets[msg.sender].currentBet;
		emit NewBetIsSet(msg.sender,bets[msg.sender].currentBet);
		//emits new event
		emit newBetAmount(msq.sender,bets[msg.sender].betAmount);
		return bets[msg.sender].currentBet,;
	}

	function roll() public returns(address , uint8 , uint8){
		require(bets[msg.sender].isBetSet == true);
		bets[msg.sender].destiny = random();
		randomFactor += bets[msg.sender].destiny;
		bets[msg.sender].isBetSet = false;
		if(bets[msg.sender].destiny == bets[msg.sender].currentBet){
			//changed to transfer bet amount
			msg.sender.transfer(betAmount*numberOfDice/2*conversionRate);
			emit GameResult(msg.sender, bets[msg.sender].currentBet, bets[msg.sender].destiny);			
		}else{
			emit GameResult(msg.sender, bets[msg.sender].currentBet, bets[msg.sender].destiny);
			//need to set way to recieve payment if they loose
		}
		return (msg.sender , bets[msg.sender].currentBet , bets[msg.sender].destiny);
	}


    function random() private view returns (uint8) {
       	uint256 blockValue = uint256(blockhash(block.number-1 + block.timestamp));
        blockValue = blockValue + uint256(randomFactor);
		//below is changed to return random between 1 and numberOfDice
        return uint8(blockValue % bets[msg.sender].numberOfDice) + 1;
    }

    function() public payable{}
	

}
