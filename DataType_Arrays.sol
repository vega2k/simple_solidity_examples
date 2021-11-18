pragma solidity ^0.4.25;

contract DataType_Arrays {
    uint[] myArray;
    uint8[3] d = [1, 2, 3];     //�Լ� �ܺο��� �����з� �迭 �ʱ�ȭ ����

    function learnArrays() public {
        //�迭�� ���������� ���Ǹ� �ڵ����� storage ������ ������ ��ġ�� memory�� ������
        uint256[] memory a = new uint256[](5);
        bytes32[] memory b = new bytes32[](10);

        a[0] = 1;   //a �迭 ù��° �ε��� ���� ���� 1 ����
        a[1] = 2;    //a �迭 �ι�° �ε��� ���� ���� 2 ����

        uint8[3] memory c = [1, 2, 3];    //�Լ��ȿ��� �������� ���� �迭 �ʱ�ȭ �� �� ������ġ memory
        uint8[3] d = [1, 2, 3];   //�Լ� ���ο��� ���ͷ��� ���� �ʱ�ȭ �ϸ鼭 memory �� ���־ �����߻�

        myArray.push(5);    //���º��� myArray ���� �迭�� push()�� ����ؼ� �������� 5�� ����
        uint myArrayLength = myArray.length;    //myArray �迭�� ���� Ȯ��

    }
}
