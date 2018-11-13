pragma solidity ^0.4.18;

/**
 * The Election contract simulates an election happening between candidates, 
   where voters are users on the blockchain.
 */
contract Election {

	//data
	struct Candidate{
		//struct to symbolize a candidate contesting the election
		uint id;
		string name;
		uint votes;
	}
	address authority = msg.sender;

	mapping (uint => Candidate) public candidates; //maps IDs of candidates to the Candidate structs
	
	mapping (address => bool) public voted;//maps voter addresses to whether they have voted or not
	

	uint public candidatesCount;

	constructor () {
		//constructor
		candidatesCount=0;
	}

	//functions
	function addCandidate (string name) public returns (bool)  {
	//Adds a candidate to the mapping of candidates contesting
	if(msg.sender!=authority)
	{
		return false;//returns false if the person trying to add the candidate isn't the person
					 //who created the smart contract
	}
	candidatesCount++;
	candidates[candidatesCount]=Candidate(candidatesCount,name,0);
	return true;	 //returns true if it passed
	}
	
	function vote(uint candidateID) public returns (bool)  {
	//Allows a voter to vote for a candidate
		require(voted[msg.sender]==false);//makes sure the candidate hasn't already voted once

		require (candidateID>0 && candidateID<=candidatesCount);//makes sure that the ID the voter
																//is voting for belongs to a candidate
		voted[msg.sender]=true;
		candidates[candidateID].votes++;
	}
	
}
