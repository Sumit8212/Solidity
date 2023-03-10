// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract VotingSystem {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    Candidate[] public candidates;

    function addCandidate(string memory _name) public {
        candidates.push(Candidate(_name, 0));
    }

    function vote(uint256 _candidateIndex) public {
        require(_candidateIndex < candidates.length, "Invalid candidate index");
        candidates[_candidateIndex].voteCount += 1;
    }

    function getWinner() public view returns (string memory) {
        uint256 maxVotes = 0;
        uint256 winningCandidateIndex = 0;
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winningCandidateIndex = i;
            }
        }
        return candidates[winningCandidateIndex].name;
    }
}
