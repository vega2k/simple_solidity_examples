pragma solidity ^0.4.25;
contract Storage_Memory {
    uint[] ages;            //storage   
                                          //[11,22,33]
    function learnDataLocation(uint[] newAges) public returns(uint a) {
        ages = newAges;     //newAges �迭�� ages �迭�� ���� ages ��: [11,22,33]
        
        uint16 myAge = 44;  //�⺻�� Ÿ����(int,uint,bool) ���ú����� ���ɶ��� memory
        
        uint[] studentAges = ages;  //�迭Ÿ���� ���ú����� ���� ���� storage
                                    	//studentAges�� ages�� ����Ű�� ������
                                    	//studentAges ���� [11,22,33]
                                    
        studentAges[0] = myAge;     //studentAges �迭�� ù��° �ε����� ���� 44�� �ٲ�
                                    	  //studentAges �� [44,22,33]
                                    	  //ages �� [44,22,33]
                                    
        a = studentAges[0];         	//44�� ���Ϻ����� ����, a�� memory                            
        return a;     
    }
}
