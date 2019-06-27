pragma solidity ^0.4.25;
contract SimpleStorageOwner {
    uint public storedData;
    // �� ���� ���� ����
    address public owner;
    // �� ������  	
    constructor() public {  owner = msg.sender; } 
    // �� ������
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    } 
    // �� set �޼��� ����
    function set(uint x) onlyOwner public {
        storedData = x;
    }
    // �� get �޼��� ����
    function get() onlyOwner public view returns (uint) {
        return storedData;
    }
}