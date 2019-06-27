pragma solidity ^0.4.25;
contract DataType_InsertStruct {
    struct User {
        string username;
        uint balacne;
    }
    
    User public myUser;
    User public myUser2;
    
    constructor() public {
        myUser.username = "유저1";
        myUser.balacne = 1000;
        
        myUser2 = User("유저2",2000);
    }
}