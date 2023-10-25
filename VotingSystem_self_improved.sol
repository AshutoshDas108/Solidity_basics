
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Ballot{
    address public chairPerson;

    struct Voter{
        uint weight;
        bool isVoted;
        address delegate;
        uint votedTo; 
    }

    struct Proposal{
        bytes32 name;
        uint voteCount;
    }

    // List of candidates to whom votes can be casted
    Proposal [] public candidateList;

    mapping (address=>Voter) voters;

    // Creates a list of valid candidates who are eligible to ask for votes
    constructor(bytes32[] memory candidateNames){
        chairPerson=msg.sender;
        voters[chairPerson].weight=1;
        for(uint ind=0; ind<candidateNames.length; ind=ind+1){
            candidateList.push(
                Proposal({
                    name: candidateNames[ind],
                    voteCount: 0
                })
            );
        }
    }

    //cahirperson will grant user the right to vote any particular proposal or delegate their votes
    function giveRightToVote(address voter) external {
        require(
            msg.sender == chairPerson,
            "Only ChairPerson can grant the right to vote"
        );

        require(
            !voters[voter].isVoted,
            "Voter has already voted"
        );

        require(voters[voter].weight==0);
        //granted a voting power equal to 1
        voters[voter].weight=1;
    }

     // delegate votes to a particular reciever address of a voter
     function delegate(address reciever) external {
        Voter storage sender = voters[msg.sender];

        require(
            !sender.isVoted,
            "Already Voted"
        );

        require(
            sender.weight!=0,
            "You are not eligible to vote"
        );

        require(
            reciever != msg.sender,
            "self delegation is not allowed"
        );

        while(voters[reciever].delegate != address(0)){
            reciever=voters[reciever].delegate;
            require(reciever != msg.sender, "Loop found in delegation hence exit");
        }

        Voter storage _delegate=voters[reciever];

        require(_delegate.weight>=1, "Not a valid recipent hence exit");

        sender.isVoted=true;
        sender.delegate=reciever;

        if(_delegate.isVoted){
            candidateList[_delegate.votedTo].voteCount+=sender.weight;
        }
        else{
            _delegate.weight=_delegate.weight+sender.weight;
        }
     }


     function vote(uint candidate) external {
         Voter storage sender = voters[msg.sender];

        require(
            !sender.isVoted,
            "Already Voted"
        );

        require(
            sender.weight!=0,
            "You are not eligible to vote"
        );

        sender.isVoted=true;
        sender.votedTo=candidate;

        candidateList[candidate].voteCount += sender.weight;
     }

     function countVotes() public view returns(uint candidateIndex_){
        uint winningVotes=0;
        for(uint p=0; p<candidateList.length; p++){
            if(candidateList[p].voteCount >= winningVotes){
                winningVotes=candidateList[p].voteCount;
                candidateIndex_=p;
            }
        }
     }

     function winner() external view returns(bytes32  winner_){
          winner_ = candidateList[countVotes()].name;
     }


    
}

