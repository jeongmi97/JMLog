package com.spring.dao;

import java.util.HashMap;
import java.util.List;

import com.spring.vo.BoardVO;

public interface UserBoardDAO {

	void write(BoardVO vo);	// 글 작성
	
	List<BoardVO> userBoardList(String email);	// 유저 보드 리스트 가져오기

	BoardVO getPost(HashMap<String, String> map);	// 게시글 가져오기
	

}
