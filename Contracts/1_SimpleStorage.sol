// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract SimpleStorage {

    uint256 favNum;

    struct People{
        uint256 favNum;
        string name;
    }

    mapping (string => uint256) map_name2favnum;

    People[] people;

    function store(uint256 _fav) public virtual {

        favNum = _fav;
    }

    function add_people(uint256 _favNum, string memory _name) public {
        // For Array or List:
        // 1st Method
        // People memory newperson = People({favNum: _favNum, name: _name});
        // people.push(newperson);

        // 2nd Method
        // People memory newperson = People(_favNum,_name);
        // people.push(newperson);

        // 3rd Method
        people.push(People(_favNum,_name));

        //For Mapping:
        //1st Method
        map_name2favnum[_name] = _favNum;
    }

    function ret_people(uint256 _index) public view returns (People memory) {

        return people[_index];
    }

    function ret_people_map(string memory _name ) public view returns (uint256) {

        return map_name2favnum[_name];
    }

    function retrieve() public view returns (uint256) {
        return favNum;
    }
}
