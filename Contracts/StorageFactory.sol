//SPDX-License-Identifier:MIT
pragma solidity 0.8.22;

import "./SimpleStorage.sol";

contract StorageFactory {

    // [1] SimpleStorage public simplestorage;

    SimpleStorage[] public simplestorageArray;

    function createSimpleStorage() public {

        // [1] simplestorage = new SimpleStorage();

        SimpleStorage simplestorage = new SimpleStorage();
        simplestorageArray.push(simplestorage);
    }

    function sfStore(uint256 _simplestorageindex, uint256 _simplestoragenumber) public {

        // [2] SimpleStorage simplestorage = simplestorageArray[_simplestorageindex];
        // simplestorage.store(_simplestoragenumber);

        simplestorageArray[_simplestorageindex].store(_simplestoragenumber);
    }

    function sfget(uint256 _simplestorageindex) public view returns (uint256) {

        // [2] SimpleStorage simplestorage = simplestorageArray[_simplestorageindex];
        // return simplestorage.retrieve();

        return simplestorageArray[_simplestorageindex].retrieve();
    }

    function sfadd_people(uint256 _simplestorageindex, uint256 _favnum, string memory _name) public {

        simplestorageArray[_simplestorageindex].add_people(_favnum,_name);
    }

    function sfRet_people(uint256 _simplestorageindex, uint256 _peopleIndex) public view returns(SimpleStorage.People memory) {

        return simplestorageArray[_simplestorageindex].ret_people(_peopleIndex);
    }

    function sfRet_people_map(uint256 _simplestorageindex, string memory _name) public view returns(uint256) {

        return simplestorageArray[_simplestorageindex].ret_people_map(_name);
    }
}
