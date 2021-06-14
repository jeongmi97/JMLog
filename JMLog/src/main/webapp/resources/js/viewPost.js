$(function(){
	// 게시글 삭제
	$('#btnDel').click(function(){
		var idx = '${post.idx}';	// 게시글 번호
		
		var chk = confirm('삭제하시겠습니까?');	// 확인창 띄우기
		if(chk) location.href="${cpath}/delPost/"+idx;	// 확인 눌렀을 때 게시글 삭제
	})
	
	// 댓글 작성
	$(btnReply).click(function(){
		if('${login.email}' == ''){		// 미로그인 상태에서 댓글 작성 시도 시 
			alert('로그인이 필요합니다!');	// 로그인 필요 알림창 띄운뒤
			$('#comment').val('');
			return;						// 댓글 작성 기능 수행 x
		}
		
		var comment = $('#comment').val().replace(/\n/g, "<br>");	// 줄바꿈 db에 넣기 위해 <br>로 치환한다
		
		if(comment == ''){				// 아무것도 입력하지 않은 채 작성 눌렀을 때
			alert('댓글을 입력해주세요!');	// 알림 표시 후 return
			return;
		}
		
		var paramData = JSON.stringify({
				"comment": comment,				// 댓글 내용
				"post_num": '${post.idx}',		// 게시글 번호
				"nickname": '${login.nickname}'	// 작성자 닉네임
		});
		
		var headers = {"Content-Type" : "application/json"
					, "X-HTTP-Method-Override" : "POST"};
		
		$.ajax({
			type:'POST',
			url: '${cpath}/${post.nickname}/${post.idx}/saveReply',
			headers: headers,
			data: paramData,
			contentType: "application/json",
			success: function(idx) {
				if(idx != 0){	// 댓글 정상적으로 insert 되면 댓글 추가 메소드 실행
					listReply(idx, comment);
					$('#comment').val('');	// 댓글 작성 폼의 값은 없애준다
				}
			},
			error: function(error){
				console.log(error);
			}
		});
	});
	
	// 작성한 댓글 추가
	function listReply(idx, comment){
		var date = new Date();
		var nowTime = date.getFullYear() + '-' + (date.getMonth()+1) + '-' + date.getDate(); // 댓글 작성 시간 구하기 yyyy-mm-dd
		var htmls = '';		// 추가할 영역에 댓글 형식에 맞게 만들어서 넣어준다 
		htmls+='<div id="reply'+idx+'"><div id="nickname">' + '${login.nickname}' + '</div><div id="reply'+idx+'actions">';
		htmls+='<p id="reply'+idx+'comment">' + comment + '</p>';
		htmls+='<div id="reply_date">' + nowTime + '</div>';
		htmls+='<div><span><a class="replyBtn" href="#" onclick="updateReply('+idx+',\''+comment+'\')" id="replyBtn'+idx+'">수정</a></span><span id="replyBtn"> | </span>';
		htmls+='<span><a class="replyBtn" href="#" onclick="delReply('+idx+')">삭제</a></span></div>';
		htmls+='</div></div><hr id="reply'+idx+'">';
		
		$("#replyList").append(htmls);	// 댓글 리스트 영역에 추가
	};
	
});

	// 댓글 삭제
	function delReply(idx){
		console.log('댓글 번호:' + idx);
		
		$.ajax({
			type: 'get',
			url: '${cpath}/${post.nickname}/${post.idx}/delReply?idx='+idx,
			success: function(data){
				console.log('삭제완료');
				$('div').remove('#reply'+idx);
				$('hr').remove('#reply'+idx);
			},
			error: function(error){
				console.log(error);
			}
		});
	};
	
	// 댓글 수정 버튼 눌렀을 때
	function updateReply(idx,comment){
		$('#reply'+idx+'actions').hide();	// 원래 댓글 내용 div 숨김
		comment = comment.toString().replace("<br>", "\r\n");
		// 댓글 수정 폼 생성 후 표시
		var htmls='';
		htmls+='<div id="updateForm"><textarea class="form-control" id="updateComment" rows="5" cols="150" placeholder="댓글을 작성하세요" style="resize: none; " escapeXml="false">'+comment+'</textarea>';
		htmls+='<div><button class="btn btn-link btn-sm" id="cancle" onclick="cancle('+idx+');">취소</button>';
		htmls+='<button class="btn btn-link btn-sm" id="update" onclick="update('+idx+');">댓글 수정</button></div></div>';
		$('#reply'+idx).append(htmls);
	};
	
	// 댓글 수정 취소
	function cancle(idx){
		$('#updateForm').remove();	// 댓글 생성 폼 삭제
		$('#reply'+idx+'actions').show();	// 댓글 내용 화면에 표시
	};
	
	// 댓글 수정
	function update(idx){
		console.log($('#updateComment').val());
		var comment = $('#updateComment').val().replace(/\n/g, "<br>")	// 수정할 내용 값
		var paramData = JSON.stringify({
			"comment": comment,
			"idx": idx
		});
		
		var headers = {"Content-Type" : "application/json"
			, "X-HTTP-Method-Override" : "POST"};
		
		$.ajax({
			type:'POST',
			url: '${cpath}/${post.nickname}/${post.idx}/updateReply',
			headers: headers,
			data: paramData,
			contentType: "application/json",
			success: function(idx){
				if(idx != 0){	// 댓글 정상적으로 insert 되면 댓글 추가 메소드 실행
					$('#reply'+idx+'comment').replaceWith('<p id="reply'+idx+'comment">' + comment + '</p>');	// 수정한 내용으로 표시
					$('#replyBtn'+idx).replaceWith('<a class="replyBtn" href="#" onclick="updateReply('+idx+',\''+comment+'\')" id="replyBtn">수정</a></span><span id="replyBtn">');
					cancle(idx);
				}
			},
			error: function(error){
				console.log(error);
			}
		});
	};