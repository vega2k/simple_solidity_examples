// “pragma solidity” 키워드는 Solidity 버전을 지정
pragma solidity ^0.5.6;
// “contract X { … }”는 X라는 컨트랙트를 정의
contract Coin {
    // “minter”는 address 타입으로 선언된 상태; address 타입은 Ethereum에서 사용하는 160-bit 주소
    // “public” 키워드는 상태를 다른 컨트랙트에서 읽을 수 있도록 허용
    address public minter;

    // “balances”는 mapping 타입으로 address 타입 데이터를 key로, uint 타입 데이터를 value로 가지는 key-value mapping
    // mapping은 타 프로그래밍 언어에서 사용하는 해시테이블 자료구조와 유사 (uninitialized 값들은 모두 0으로 초기화되어 있는상태)
    mapping (address => uint) public balances;

    // event로 정의된 타입은 클라이언트(e.g., application using a platform-specific SDK/library)가
    // listening 할 수 있는 데이터로 emit 키워드로 해당 타입의 객체를 생성하여 클라이언트에게 정보를 전달
    // usage:
    // /* in Solidity */
    // emit Sent(an_address, another_address, 10);
    // /* in Web3.js */
    // Coin.Sent().watch({}, ‘’, function(err, result) { … });
    event Sent(address from, address to, uint amount);


    // N.B. 컨트랙트 함수는 함수를 실행한 TX의 정보를 받을 수 있는데 해당 정보를 msg 변수로 접근
    // 자세한 정보는 https://solidity.readthedocs.io/en/v0.4.24/units-and-global-variables.html#block-and-transaction-properties를 참조
    // 생성자 함수는 컨트랙트가 생성될 때 한번 실행
    // 아래 함수는 minter 상태변수에 msg.sender값을 대입 (함수를 실행한 사람의 주소)
    constructor() public {
        minter = msg.sender;
    }

    // receiver 주소에 amount 만큼의 새로운 Coin을 부여
    // require 함수는 입력값이 true일때만 다음으로 진행할 수 있음 (타 언어의 assert와 유사)
    // require 함수는 특정조건을 만족할 경우에만 함수를 실행할 수 있도록 강제할 때 사용
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter); // 함수를 실행한 사람이 minter(i.e., 컨트랙트 소유자)일때만 진행
        require(amount < 1e60); // 새로 생성하는 Coin의 양이 1 * 10^60개 미만일때만 진행
        balances[receiver] += amount; // receiver 주소에 amount만큼을 더함
    }

    // msg.sender가 receiver에게 amount만큼 Coin을 전송
    function send(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "Insufficient balance."); // 잔고가 충분한지 확인
        balances[msg.sender] -= amount; // 잔고 차감
        balances[receiver] += amount; // 잔고 증가
        emit Sent(msg.sender, receiver, amount); // 이벤트 생성
    }


}