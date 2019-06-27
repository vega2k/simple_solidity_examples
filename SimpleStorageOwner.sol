pragma solidity ^0.4.25;
contract SimpleStorageOwner {
    uint public storedData;
    // ① 상태 변수 선언
    address public owner;
    // ② 생성자  	
    constructor() public {  owner = msg.sender; } 
    // ③ 제한자
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    } 
    // ④ set 메서드 선언
    function set(uint x) onlyOwner public {
        storedData = x;
    }
    // ④ get 메서드 선언
    function get() onlyOwner public view returns (uint) {
        return storedData;
    }
}