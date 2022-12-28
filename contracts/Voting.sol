pragma solidity ^0.5.16;

contract Voting {
    uint totalCandidate;
    uint totalVoter;
    uint totalVoted;

    struct Candidate {
        bytes32 CandidateName;
        bytes32 partyName;
        uint votes;
    }


    struct Voter {
        uint candidateVoteId;
        bool voted;

    }


    mapping(uint => Candidate) public candidateList;
    mapping(address => Voter) public voters;


    function addCandidate(bytes32 _name, bytes32 _party) public  {
        uint i = totalCandidate++;
        candidateList[i] = Candidate(_name, _party, 0);
    }


    
    event toVoteEvent(uint totalVoted);


    function toVote(uint candidateID) public {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "Altready voted");

        sender.voted = true;
        candidateList[candidateID].votes += 1;
        totalVoted += 1;
        totalVoter +=1;
    }



    function getNumberOfCandidates() public view returns (uint){
        return totalCandidate;
    }


    function getNumberOfVoters() public view returns (uint){
        return totalVoter;
    }


    function checkWinner() public view returns (uint wins){
        uint winCount = 0;
        for (uint i = 0; i <= totalCandidate; i++){
            if (winCount < candidateList[i].votes){
                winCount = candidateList[i].votes;
                wins = i;
            }
        }
    }



    function winnerVotes() public view returns (uint vote){
        vote = candidateList[checkWinner()].votes;
    }


    function winnerName() public view returns (bytes32 name){
        name = candidateList[checkWinner()].CandidateName;
    }


}