// 이메일 & 비밀번호 정규표현식
const patternEmail = RegExp(/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/);
// 영문자 숫자 조합 8자 이상
const patternPw = RegExp(/^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/);	

// 입력값 제약조건 확인 배열 [이메일, 비밀번호, 비밀번호 확인, 닉네임]
var btnChk = ['n', 'n', 'n', 'n'];

$(document).ready(function(){

// 각 입력값의 경고 텍스트 숨김
$('.alert').hide();
	
// 이메일 정규표현식 확인 & 중복체크
$('#email').blur(function() {
	const email = $('#email').val();
	var idmsg = $('#idmsg');
	
	if(email == ''){	// 이메일 미입력 시
		idmsg.text("이메일을 입력해주세요");
		return;
	}else if(!patternEmail.test(email)){	// 이메일 정규표현식에 맞지 않을 때
		idmsg.text("이메일 형식에 맞게 입력해주세요");
		btnChk[0] = 'n';
		$('#idmsgAlert').show();
		return;
	}else{		// 이메일 정규표현식에 맞을 경우 ajax를 통해 계정 중복 테스트
		$.ajax({
			// 데이터를 get 방식으로 url에 붙여 전송
			type: "GET",
			url: 'emailCheck?email='+email,
			success: function(data){
				// return값을 int값으로 받아와 select된 계정이 1개 이상이면 사용중인 계정
				if(data > 0){
					idmsg.text('이미 사용중인 계정입니다');
					$('#idmsgAlert').show();	// 경고 텍스트 나타냄
					btnChk[0] = 'n';			// 제약조건 확인배열에 no값 넣는다
				}else{
					$('#idmsgAlert').hide();	// 경고 텍스트 숨김
					btnChk[0] = 'y';			// 제약조건 확인배열에 yes값 넣는다
				}
			}
		})
	}
});

// 비밀번호 정규표현식 확인
$('#pw').blur(function(){
	const pw = $('#pw').val();
	var pwmsg = $('#pwmsg');
	
	if(pw == ''){	// 미입력시
		pwmsg.text("비밀번호를 입력해주세요");
		return;
	}else if(!patternPw.test(pw)){	// 정규표현식과 맞지않을 때
		pwmsg.text("영문 대소문자, 숫자를 조합한 8자 이상");
		$('#pwmsgAlert').show();
		btnChk[1] = 'n';
		return;
	}else{
		$('#pwmsgAlert').hide();
		btnChk[1] = 'y';
	}
});

// 비밀번호 확인
$('#pwChk').blur(function(){
	const pw = $('#pw').val();
	const pwChk = $('#pwChk').val();
	var cpwmsg = $('#cpwmsg');
	
	if(pwChk == ''){
		cpwmsg.text("비밀번호 확인을 입력해주세요");
		return;
	}else if(pw != pwChk){
		cpwmsg.text("비밀번호가 일치하지 않습니다");
		$('#cpwmsgAlert').show();
		btnChk[2] = 'n';
		return;
	}else{
		$('#cpwmsgAlert').hide();
		btnChk[2] = 'y';
	}
});

// 닉네임 중복확인
$('#nickname').blur(function() {
	const nickname = $('#nickname').val();
	var nnamemsg = $('#nnamemsg');
	
	if(nickname == ''){
		nnamemsg.text("닉네임을 입력해주세요")
		return;
	}else{
		$.ajax({
			type: 'GET',
			url: 'nicknameChk?nickname=' + nickname,
			success: function(data) {
				if(data != ''){		// data가 존재할 때
					nnamemsg.text('이미 사용중인 닉네임입니다');
					$('#nnamemsgAlert').show();
					btnChk[3] = 'n';	
				}else{
					$('#nnamemsgAlert').hide();
					btnChk[3] = 'y';
				}
			}
		})
	}
});

});

// 인풋값들이 제약조건에 모두 성립 시 가입하기 버튼 활성화
function btnchk(){	
	var check = 'y';	// 제약조건 체크 변수
	for(var i=0; i<4; i++){
		if(btnChk[i] == 'n')	// 배열에 n 값이 있으면
			check = 'n';		// 체크변수에 n 넣음
	}
	if(check == 'y')			// 체크변수가 y일 때
		$('form').submit();		// 회원가입 폼 전송
	else{
		alert('입력정보를 확인해주세요!');	// 알림 나타낸 후
		return;						// return
	}
	
}