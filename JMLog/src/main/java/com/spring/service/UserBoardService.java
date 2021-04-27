package com.spring.service;


import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dao.UserBoardDAO;
import com.spring.dao.UserDAO;
import com.spring.vo.BoardVO;
import com.spring.vo.UserVO;

@Service
public class UserBoardService {

	@Autowired UserBoardDAO dao;
	@Autowired UserDAO udao;
	
	// 유저 블로그로 이동
		public ModelAndView userBoard(String email) {
			ModelAndView mav = new ModelAndView("userBoard");
		
			System.out.println("넘어온 이메일 : " + email);
			
			mav.addObject("user", udao.userChk(email));
			mav.addObject("uBoard",dao.userBoardList(email));
			System.out.println(dao.userBoardList(email).get(0).toString());
			return mav;
		}
	
	// 글 쓰기
	public ModelAndView write(BoardVO vo, UserVO login, RedirectAttributes ra) {
		ModelAndView mav = new ModelAndView();
		
		vo.setEmail(login.getEmail());
		dao.write(vo);
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("email", vo.getEmail());
		param.put("title", vo.getTitle());
		vo = dao.getPost(param);
		
		mav.setViewName("redirect:/"+login.getEmail()+"/"+vo.getTitle());
		
		return mav;
	}

	// 게시글 이동
	public ModelAndView viewPost(String email, String title) {
		ModelAndView mav = new ModelAndView("viewPost");
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("email", email);
		param.put("title", title);
		BoardVO post = dao.getPost(param);
		
		mav.addObject("post",post);
		
		return mav;
	}

	// 소개
	public ModelAndView about(String email) {
		ModelAndView mav = new ModelAndView("about");
		
		return mav;
	}

	// 수정
	public ModelAndView setting(String email) {
		ModelAndView mav = new ModelAndView("setting");
		
		return mav;
	}

}
