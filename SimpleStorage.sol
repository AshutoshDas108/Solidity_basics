// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage{

    struct Candidate{
        uint256 favNum;
        string name;
    }
    Candidate [] public candidates;

    mapping (string=>uint256) public candidateToFavNum;

    //store favorite numbers-- by id
    function store(uint256 _favNum, string memory _name) public {
        candidates.push(Candidate ({favNum: _favNum, name:_name}));
        candidateToFavNum[_name]=_favNum;
    }

    //show favorite number of a particular candidate 

    // i- by the id
    function showFavNumbyID(uint256 _id)public view returns(uint256){
        if(_id>=candidates.length) revert("Not a Valid User");
        return (candidates[_id].favNum);
    }

    // ii-by the name of user

    function showFavNumbyName(string memory _name)public view returns(int256){
        if(candidateToFavNum[_name]==0){
          revert("Not a Valid User");
        }
        return int(candidateToFavNum[_name]);
    }


    //Update favorite Number of a particular user 

    // i- by the user id (index)
    function updateFavNumByID(uint256 _id, uint256 _newFavNum)public {
          if(_id<candidates.length)
            candidates[_id].favNum = _newFavNum;
          else 
            revert("Not a valid user");
    }

    // ii- by the name of the user
    function updateFavNumByName(string memory _name, uint256 _newFavNum)public {
        if(candidateToFavNum[_name]==0) revert("Not a Valid User");
        candidateToFavNum[_name]=_newFavNum;
    }

}
