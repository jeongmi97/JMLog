package com.spring.service;


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
	
	public ModelAndView write(BoardVO vo, UserVO login, RedirectAttributes ra) {
		ModelAndView mav = new ModelAndView("redirect:/"+login.getEmail());
		
		vo.setEmail(login.getEmail());
		dao.write(vo);
		ra.addAttribute("postid",vo.getIdx());
		
		return mav;
	}

	public ModelAndView viewPost(String email, String title, int postid) {
		ModelAndView mav = new ModelAndView("viewPost");
		
		BoardVO post = dao.getPost(postid);
		
		mav.addObject("post",post);
		
		return mav;
	}

}
