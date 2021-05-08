package com.spring.dao;

import java.util.HashMap;

import com.spring.vo.UserVO;

public interface UserDAO {
	
	UserVO userChk(String email);

	int join(UserVO vo);

	int emailCheck(String email);

	String getProfileImg(String email);

	void setProfileImg(HashMap<String, String> param);


}
