package com.spring.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.spring.vo.CategoryVO;
import com.spring.vo.UserVO;

public interface UserDAO {
	
	UserVO userChk(String email);

	int join(UserVO vo);

	int emailCheck(String email);
	
	void keepLogin(HashMap<String, Object> param);	// 로그인 유지
	
	UserVO checkUserSession(String sessionid);		// 세션키 확인

	void setProfileImg(HashMap<String, Object> param);

	void settingUser(UserVO vo);

	String nicknameChk(String nickname);	// 닉네임 중복 확인

	void setNickname(UserVO vo);		// 닉네임 수정

	Map<String, Object> getProfileImg(String email);	// 유저 프로필 이미지 가져오기

	List<CategoryVO> getCategory(String email);	// 유저 카테고리 가져오기

	void delimg(String email);	// 프로필 이미지 제거

	String getNickname(String email);	// 닉네임 수정 - 원래 닉네임 가져오기
	
	void updatePostNickname(HashMap<String, String>param);	// 닉네임 수정 - 게시글 닉네임 수정
	
	void updateReplyNickname(HashMap<String, String> param);// 닉네임 수정 - 댓글 닉네임 수정


}
