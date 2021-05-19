package com.spring.dao;

import java.util.HashMap;
import java.util.List;

import com.spring.vo.BoardVO;
import com.spring.vo.CategoryVO;
import com.spring.vo.ReplyVO;

public interface UserBoardDAO {

	void write(BoardVO vo);	// 글 작성
	
	List<BoardVO> userBoardList(HashMap<String, Object> param);	// 유저 보드 리스트 가져오기

	int getPostnum(String email);	// 작성한 글 번호 가져오기
	
	BoardVO getPost(int idx);	// 게시글 가져오기

	void updatePost(BoardVO vo);	// 게시물 수정

	void delPost(int idx);	// 게시글 삭제

	List<ReplyVO> getReply(int post_num);	// 댓글리스트 가져오기

	void saveReply(ReplyVO reply);	// 댓글 저장

	void delPostReply(int idx);	// 게시글삭제 시 댓글 삭제

	void delReply(int idx);	// 댓글 삭제

	int getReplyIdx(String nickname);	// 댓글 번호 가져오기

	void updateReply(ReplyVO reply);	// 댓글 수정

	int getBoardListCnt(String email);	// 총 게시글 개수 확인

	List<CategoryVO> getCategory(String email);	// 유저 카테고리 가져오기

	List<BoardVO> cateBoardList(HashMap<String, Object> param);	// 카테고리별 보드 리스트 가져오기

	int getCateBoardList(HashMap<String, Object> param);	// 카테고리별 게시글 개수 가져오기


	
	
}
