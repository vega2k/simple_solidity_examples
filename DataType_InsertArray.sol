pragma solidity ^0.4.25;
contract DataType_InsertArray {
    //static array
    uint[5] public staticArr = [1,2,3,4,5];
    //dynamic array
    uint[] public dynamicArr = [1,2,3,4,5];
    uint[] public dynamicArr2;
    uint public arrLength;   

    constructor() public {
        staticArr[0] = 10;
        staticArr[1] = 20;
        staticArr[2] = 30;

        dynamicArr.push(6);
        dynamicArr.push(7);

        dynamicArr2.push(10);
        dynamicArr2.push(20);
        arrLength = dynamicArr2.length;
    }
}
