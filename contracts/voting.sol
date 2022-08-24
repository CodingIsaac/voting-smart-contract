// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Voting {

    /**
     * This is a voting smart contract and what are the things we are exploring"
     * a. candidacy to vote.
     * b. who will declare the vote opened?
     * c. voting periods - how do we capture the before, during and after voting?
     * d. How do we keep record of the vote per the address and the person voted?
     * f. Can the voters delegate their power to vote to another person?
     * g. determine the metrics of who won the vote
     * 
     */

    // A struct to help us collect the data of the vandidates for the polls.

    struct Candidates {
        uint candidateID;
        string candidateName;
        uint candidateVoteCount;
        
    }
//  A struct to determine the number of votes per voter and the candidate voted for.
    struct validVoter {
        uint vote;
       bool voted;
        uint authorized;
    }

    // the voting controllers controls the voting process from start to finish.

    address public votingController;

    // an array to collect data of the same type.

    Candidates[] public candidates;

    // enum votingState {Created, Voting, Ended}
    // votingState public state;
    bool public Created; 
    bool public votingStarted;
    bool public Ended;

    mapping(address => validVoter) public voters;

    string public electionName;

    // This is an access modifier

    /// Voting has not Commenced

    error VotingNotStarted();

    /// Voting has Ended

    error VotingHasEnded();

    /// You are not the Voting Controller

    error notManager();

    /// Voting Period not reached
    error VotingSeasonNotReached();

    modifier onlyController() {
        if (msg.sender != votingController) {
            revert notManager();
        }
        _;
    }

    modifier votingNotStarted() {
        if (!votingStarted) {
            revert VotingNotStarted();
        }
        _;
    }

    modifier votingHasEnded() {
        if (!Ended) {
            revert VotingHasEnded();

        }
        _;
    }

    modifier votingSeason() {
        if (!Created) {
            revert VotingSeasonNotReached();
        }
        _;
    }




    constructor() {
        votingController = msg.sender;
        // state = votingState.Created;
        

        
    }



}