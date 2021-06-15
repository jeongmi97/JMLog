package com.spring.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.spring.vo.CategoryVO;
import com.spring.vo.UserVO;

public interface UserDAO {
	
	UserVO userChk(String email);	// 유저 유무 체크

	void keepLogin(HashMap<String, Object> param);	// 로그인 유지
	
	int join(UserVO vo);	// 회원가입

	int emailCheck(String email);	// 이메일 중복 체크
	
	List<CategoryVO> getCategory(String email);	// 유저 카테고리 가져오기
	
	String nicknameChk(String nickname);	// 닉네임 중복 확인
	
	void setProfileImg(HashMap<String, Object> param);	// 프로필 이미지 저장
	
	String getNickname(String email);	// 닉네임 수정 - 원래 닉네임 가져오기
	
	void setNickname(UserVO vo);		// 닉네임 수정
	
	void updatePostNickname(HashMap<String, String>param);	// 닉네임 수정 - 게시글 닉네임 수정
	
	void updateReplyNickname(HashMap<String, String> param);// 닉네임 수정 - 댓글 닉네임 수정
	
	Map<String, Object> getProfileImg(String email);	// 유저 프로필 이미지 가져오기
	
	void delUserReply(String nickname);		// 회원 탈퇴 - 댓글 삭제
	
	void delUserBoard(String nickname);		// 회원 탈퇴 - 게시글 삭제
	
	void deluser(String nickname);			// 회원 탈퇴 
	
	UserVO checkUserSession(String sessionid);		// 세션키 확인

	void delimg(String email);	// 프로필 이미지 제거

	





}
