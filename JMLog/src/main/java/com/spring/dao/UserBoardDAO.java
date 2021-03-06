package com.spring.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.spring.vo.BoardVO;
import com.spring.vo.CategoryVO;
import com.spring.vo.GuestbookVO;
import com.spring.vo.Pagination;
import com.spring.vo.ReplyVO;

public interface UserBoardDAO {
	
	int getListCnt();	// 전체 게시글 개수 가져오기
	
	List<BoardVO> getPostList(Pagination vo);	// 인기순 전체 글 가져오기
	
	List<BoardVO> getNewPostList(Pagination vo); // 최신순 전체 글 가져오기

	String getEmail(String nickname);	// 닉네임으로 이메일 찾기
	
	int getBoardListCnt(String nickname);	// 총 게시글 개수 확인
	
	void write(BoardVO vo);	// 글 작성
	
	List<BoardVO> userBoardList(HashMap<String, Object> param);	// 유저 보드 리스트 가져오기
	
	List<BoardVO> cateBoardList(HashMap<String, Object> param);	// 카테고리별 보드 리스트 가져오기
	
	List<BoardVO> userLockBoardList(HashMap<String, Object> param);	// 비밀글 제외 유저 보드 리스트

	List<BoardVO> cateLockBoardList(HashMap<String, Object> param);	// 비밀글 제외 카테고리별 리스트

	int userAllBoardCnt(String nickname);	// 유저의 모든 게시글 개수 가져오기
	
	List<CategoryVO> getCategory(String email);	// 유저 카테고리 가져오기
	
	String getboardCate(BoardVO vo);	// 수정 전 게시글 카테고리 가져오기
	
	void minusCateCnt(HashMap<String, Object> param);	// 카테고리 수정 시 원래 카테고리 카운트 -1 하기
	
	void updatePost(BoardVO vo);	// 게시물 수정
	
	int getPostnum(String nickname);	// 작성한 글 번호 가져오기
	
	int getCateCnt(HashMap<String, Object> param);	// 선택한 카테고리 개수 가져오기

	void updateCateCnt(HashMap<String, Object> param);	// 추가된 카테고리 개수 업데이트 하기
	
	void updateHit(int idx);	// 조회수 업데이트
	
	Object getAbout(String nickname);	// 소개글 가져오기
	
	void writeAbout(BoardVO vo);	// 소개글 작성
	
	void updateAbout(BoardVO vo);	// 소개글 수정
	
	void delPostReply(int idx);	// 게시글삭제 시 댓글 삭제

	void delPost(int idx);	// 게시글 삭제
	
	void saveReply(ReplyVO reply);	// 댓글 저장
	
	void delReply(int idx);	// 댓글 삭제

	int getReplyIdx(String nickname);	// 댓글 번호 가져오기
	
	void updateReply(ReplyVO reply);	// 댓글 수정
	
	void setCategory(HashMap<String, Object> param);	// 카테고리 추가
	
	void delCate(Map<String, Object> param);	// 카테고리 삭제
	
	void delPostCate(Map<String, Object> param);	// 카테고리 삭제 - 게시글 카테고리 수정

	void updateCate(Map<String, Object> category);	// 카테고리 수정

	void updatePostCate(Map<String, Object> param);	// 카테고리 수정 - 게시글 카테고리 수정
	
	List<GuestbookVO> getguestList(String email);	// 방명록 리스트 가져오기
	
	void insertguest(GuestbookVO vo);	// 방명록 작성
	
	void updateguest(GuestbookVO vo);	// 방명록 수정

	void delGuest(int idx);	// 방명록 삭제
	
	List<BoardVO> getBoardList(int startList);	// 스크롤 페이징(인기순)
	
	int getCateBoardList(HashMap<String, Object> param);	// 카테고리별 게시글 개수 가져오기
	
	BoardVO getPost(int idx);	// 게시글 가져오기
	
	List<ReplyVO> getReply(int post_num);	// 댓글리스트 가져오기

}
