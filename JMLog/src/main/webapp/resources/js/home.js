//이전 버튼 이벤트
function prev(page, range, rangeSize){
	var page = ((range)-2 * rangeSize) + 1;	// 무조건 이전 페이지 범위의 가장 앞 페이지로 이동하기 위해 처리
	var range = range - 1; 
	
	// email?page=page&range=range
	var url = '${cpath}/?page='+ page + '&range=' + range;
	
	location.href = url;
}

// 페이지 번호 클릭
function pagination(page, range){
	var url = '${cpath}/?page='+ page + '&range=' + range;
	
	location.href = url;
}

//다음 버튼 이벤트
function fn_next(page, range, rangeSize) {
	var page = parseInt((range * rangeSize)) + 1;
	var range = parseInt(range) + 1;

	var url = '${cpath}/?page='+ page + '&range=' + range;

	location.href = url;
}
