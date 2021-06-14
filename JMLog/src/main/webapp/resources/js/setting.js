$(function(){
	$('.alert').hide();	// 경고 알림 숨김
	
	// 닉네임 중복 확인
	$('#nickname').blur(function() {	// 닉네임 입력창 벗어나면
		const nickname = $('#nickname').val();	// 입력한 닉네임 값
		var nnamemsg = $('#nnamemsg');
		var loginnickname = '${login.nickname}';	// 로그인중인 유저 닉네임
		
		if(nickname == ''){	// 아무것도 입력 안했을 때
			nnamemsg.text("닉네임을 입력해주세요!")
			$('#nnamemsgAlert').show(); // 경고 알림 나타내기
			$('#saveBtn').prop("disabled",false);	// 수정 버튼 비활성화
			return;
		}else if(nickname != loginnickname){	// 입력한 닉네임과 유저 닉네임이 같지 않을 때
			$.ajax({
				type: 'GET',
				url: 'nicknameChk?nickname=' + nickname,
				success: function(data) {	// 중복된 닉네임이 존재하면 select된 값 넘어옴
					if(data == ''){		// 넘어온 값이 없을때(중복x)
						$('#nnamemsgAlert').hide();				// 경고 알림창 숨김
						$('#saveBtn').prop("disabled",false);	// 수정 버튼 활성화
					}else{	// 넘어온 값이 있을 때(중복o)
						nnamemsg.text('이미 사용중인 닉네임입니다!');
						$('#nnamemsgAlert').show();				// 경고 알림창 나타냄
						$('#saveBtn').prop("disabled",true);	// 수정 버튼 비활성화
					}
				}
			})
		}
	});
	
	// 프로필 이미지 선택 미리보기
	$('#profileimg').on("change", function(){
		var file = $(this).prop('files')[0];
		console.log('files : ' + file);
		console.log('선택 : ' + $('#profileimg').val());
		if($('#profileimg').val() == '')
			$('#imgChk').val('no');		// 파일 선택 취소했을 때 프로필 사진 안바뀌게 no 전해줌
		console.log('imgchk : ' + $('#imgChk').val());
		blobURL = window.URL.createObjectURL(file);
		$('.img').attr('src', blobURL);
	});
	
	// 프로필 이미지 제거
	$('#delimg').click(function(){
		$.ajax({
			type: 'GET',
			url: 'delimg?email=' + '${login.email}',
			success: function(){
				// 프로젝트 내 폴더에 있는 기본 이미지 보여줌
				$('.img').attr('src', 'resources/img/default.jpg');
			}
		});
	});
})

// 회원 탈퇴
function delUser(){
	var delconfirm = confirm('관련 데이터들은 복구되지 않습니다. 정말 탈퇴하시겠습니까?');
	if(delconfirm == true){		// 확인 눌렀을 때 탈퇴 기능 수행
		$.ajax({
			type: 'get',
			url: 'deluser?nickname='+'${login.nickname}',
			success: function(){
				alert('탈퇴가 완료되었습니다.');
				location.replace('/');
			}
		})
	}else{						// 취소 눌렀을 때 되돌아가기
		return;
	}
}
