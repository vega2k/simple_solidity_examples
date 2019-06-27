pragma solidity ^0.4.25;
contract DataType_Mappings {
    mapping(address => uint256) balance;
    
    struct Student {
        string studentName;
        string gender;
        uint age;
    }

    mapping(uint256 => Student) studentInfo;

    function learnMapping() public returns(uint256) {
        balance[msg.sender] = 100;
        balance[msg.sender] += 100;

        uint256 currentBalance = balance[msg.sender];
        return currentBalance;
    }
    
   function setStudentInfo(uint _studentId, string _name, string _gender, uint _age) public {
        Student storage student = studentInfo[_studentId];  //Ű������ Ư�� Student ����ü�� �ҷ��´�.

        //����ü ���� �ʵ忡 �ƱԸ�Ʈ�� ���� ������ ����
        student.studentName = _name;
        student.gender = _gender;
        student.age = _age;
    }

    function getStudentInfo(uint256 _studentId) view public returns(string,string,uint) {
        return (studentInfo[_studentId].studentName, studentInfo[_studentId].gender, studentInfo[_studentId].age);
    }
}

