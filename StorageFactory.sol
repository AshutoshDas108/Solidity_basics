//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory{

   SimpleStorage [] public simplestorageList;
   mapping (SimpleStorage=>uint256) public storageToid;
   uint id=0;

   //create a list of simple storage created
   function createSimpleStorage() public {
       SimpleStorage simplestorage = new SimpleStorage();
       simplestorageList.push(simplestorage);
       storageToid[simplestorage]=++id;
   }

   //interacting with simple storage function

   //store favorite number 
   function storeSimpleStorage(uint256 _favNum, uint256 _id, string memory _name) public  {
     SimpleStorage store1 = simplestorageList[_id];
     store1.store(_favNum, _name);
   }


   function showSimpleStorage(uint256 _id) public view {
       SimpleStorage store2=simplestorageList[_id];
       store2.showFavNumbyID(_id);
   }

   function updateSimpleStorage(uint256 _id, uint256 _newFavNum) public {
        SimpleStorage store3=simplestorageList[_id];
        store3.updateFavNumByID(_id, _newFavNum);
   }
   
}
