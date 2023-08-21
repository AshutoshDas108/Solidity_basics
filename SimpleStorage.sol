// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8; // first varify the version of solidity--anyversion above ^0.8.7
                        // >=0.8.7 <0.9.0 spacifying a range of version


// contract is similar to class in OOPs
contract SimpleStorage {
    //Basic types in solidity
    //boolean , unit, int, address, byte
    bool hasFavNumber=true;
    uint256 num=123;
    int256 num1=234;
    string numFav="123";
    address ad; // stores address of the wallet etc
    bytes32 b="cat"; //stores in form 0x1234ghjhj -- automatically converted | size of bytes can be specified
    uint256 a; // by default initialized to 0


     //NOTE: Every single smart contract have a address just like our wallet accounts
    // When we deploy a contract -> to sending a transaction 
    // Any time we change something on-chain, including making a new contract, it happens in a transaction
    // public variables implicitly get assigned a function that returns its value
    // default visibility modifier is -- internal
    // More stuff we do more is the cost i.e, gas fees


    //STRUCT

    struct People {
        uint256 fav_num;
        string name;
    }
    
    // list of objects gets automatically indexed
    People public person =People({fav_num:2, name:"Ashutosh"});
    //creating list of persons -- using Array

    People [] public people; // currently an empty list--dynamic array(size not specified)
   // uint256 [] public arr;

    function addPerson(string memory _name, uint256 _fav_num) public {
        People memory newPerson = People(_fav_num, _name);
        people.push(newPerson);
    }


    //FUNCTIONS

    function store(uint256 _favNum) public {
        num=_favNum;
       // num=num+1;
       uint256 testvar=8;
       testvar=testvar+1;
    }

    function retrive() public view returns(uint256){
        return num;
    }

    //view and pure functions when called alone does not spend gas--they dont allow modification of state
    //pure functions additionally disallow to read from blockchain state

    //pure function
    function add() public pure returns (uint256){
        return (1+1);
    }
    //gas is charged only if we modify the blockchain state

    //WARNINGS AND ERRORS
    

}
