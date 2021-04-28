package com.spring.dao;

import java.util.List;

import com.spring.vo.BoardVO;

public interface UserBoardDAO {

	void write(BoardVO vo);	// 글 작성
	
	List<BoardVO> userBoardList(String email);	// 유저 보드 리스트 가져오기

	int getPostnum(String email);	// 작성한 글 번호 가져오기
	
	BoardVO getPost(int idx);	// 게시글 가져오기

	void updatePost(BoardVO vo);	// 게시물 수정

	void delPost(int idx);	// 게시글 삭제

	
	
}
