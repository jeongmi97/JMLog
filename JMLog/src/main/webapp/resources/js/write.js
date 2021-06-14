$(document).ready(function() {
	
	$('.summernote').summernote({
		height: 300,	// 에디터 높이
		lang: "ko-KR",	// 에디터 한글 설정
		focus : true,	// 에디터에 커서 이동
		toolbar: [
			// 글꼴 설정
		    ['fontname', ['fontname']],
		    // 글자 크기 설정
		    ['fontsize', ['fontsize']],
		    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
		    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
		    // 글자색
		    ['color', ['forecolor','color']],
		    // 글머리 기호, 번호매기기, 문단정렬
		    ['para', ['ul', 'ol', 'paragraph']],
		    // 줄간격
		    ['height', ['height']],
		    // 그림첨부, 링크만들기
		    ['insert',['link']], //'picture',
		    // 코드보기, 확대해서보기, 도움말
		    ['view', ['codeview', 'help']]
		  ],
		  // 추가한 글꼴
		fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
		 // 추가한 폰트사이즈
		fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']    
	});
	
	// 게시글 수정 시 입력 폼 셋팅
	var mode = '${mode}';	// 게시글 모드 가져옴
	
	if(mode == 'edit'){	// 수정 모드일때
		$("input:hidden[name='idx']").val('${post.idx}');
		$("input:hidden[name='mode']").val('${mode}');	// 일반과 수정모드를 구분하기 위한 값 넘김
		$('#title').val('${post.title}');
		$('#content').val('${post.content}');

	}
	
});