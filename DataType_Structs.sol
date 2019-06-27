pragma solidity ^0.4.25;
contract DataType_Structs {
    struct Student {
        string studentName;
        string gender;
        uint age;
    }
    Student[] students;
    function addStudent(string _name, string _gender, uint _age) public {
        students.push(Student(_name, _gender, _age));    //students ���º��� �迭�� ���ο� Student �Է�

        Student storage updateStudent = students[0];    //storage�� �����ϴ� ���ο� Student ����
                                                        //���º��� students �迭�� ù��° �ε��� ���� ����
                                                        //storage�� �����߱� ������ ���º����� ����Ű�� ������ ����
        updateStudent.age = 55;       //updateStudent�� age �ʵ带 55�� ����
                                      //��������� ���º��� students �迭�� ù��° �ε����� age �ʵ带 55�� �����Ѵ�
        Student memory updateStudent2 = students[0];    //memory�� �����ϴ� ���ο� Student ����
                                                        //���º��� students �迭�� ù��° �ε��� ���� ����
                                                        //memory�� ����Ʊ� ������ �����Ѵ�.
        updateStudent2.age = 20;     //updateStudent2�� age �ʵ带 20���� ���� 
                                     //��������� updateStudent2�� age�ʵ常 �����ϰ� students �迭�� age�ʵ�� ������� �ʴ´� 
   }
}
