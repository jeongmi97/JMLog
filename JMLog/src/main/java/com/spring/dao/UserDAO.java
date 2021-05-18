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

	void setProfileImg(HashMap<String, Object> param);

	void settingUser(UserVO vo);

	int nicknameChk(String nickname);

	void setNickname(UserVO vo);

	Map<String, Object> getProfileImg(String email);

	void setCategory(HashMap<String, Object> param);

	List<CategoryVO> getCategory(String email);

	void delCate(int idx);

	void updateCate(CategoryVO category);


}
