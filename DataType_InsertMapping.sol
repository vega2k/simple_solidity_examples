pragma solidity ^0.4.25;
contract DataType_InsertMapping {
    mapping(string => uint) mapUsers;
    
    constructor() public {
        mapUsers["����1"] = 10000;
        mapUsers["����2"] = 20000;
    }
    
    function getBalance(string _name) public view returns(uint) {
        return mapUsers[_name];
    }
}