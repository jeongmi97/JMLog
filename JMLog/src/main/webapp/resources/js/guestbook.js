$(function(){
		
	// 작성 버튼 클릭 시
	$('#insertBtn').on('click', function(){	
		var email = '${user.email}';
		var nickname = '${login.nickname}';
		var content = $('#content').val();
		
		content = $('#content').val().replace(/\n/g, "<br>");	// DB에 줄바꿈 내용까지 저장 되도록 태그 치환하여 넣기
		$('#content').val(content);
		
		if('${login.email}' == ''){	// 미로그인상태에서 방명록 작성 기능 x
			alert('로그인이 필요합니다!');
			return;
		}else if(content == ''){	// 아무것도 입력하지 않은 채 작성 눌렀을 때
			alert('글을 입력해주세요!');
			return;
		}else
			$('#insertForm').submit();		// 조건 만족 시 폼 전송
	});
	
	$('#updateBtn').on('click', function(){
		var content = $('#updateContent').val().replace(/\n/g, "<br>");
		$('#content').val(content);
		
		if(content == ''){	// 아무것도 입력하지 않은 채 작성 눌렀을 때
			alert('글을 입력해주세요!');
			return;
		}else
			$('form').submit();		// 조건 만족 시 폼 전송
	});
	
	$('#updateGuest').on('show.bs.modal', function(e){	// 모달 호출 버튼 눌렀을 때
		var content = $(e.relatedTarget).data('test');	// 호출 버튼에 넣어놓은 값 가져옴(원래 방명록 내용)
		console.log('====='+content);
		if(content.toString().indexOf('<br>') >= 0 )
			$('#updateContent').val(content.replace("<br>", "\r\n")); // <br> 태그 치환 후 textarea에 넣어줌
	});
});

function delGuest(idx){
	$.ajax({
		type: 'get',
		url: '${cpath}/${user.email}/guestbook/delGuest?idx=' + idx,
		success: function(){
			$('div').remove('#guest' + idx);
		}
	});
}