package com.spring.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.dao.UserDAO;
import com.spring.vo.UserVO;

@Service
public class UserService {

	@Autowired UserDAO dao;
	
	@Autowired BCryptPasswordEncoder pwEncoder;
	@Bean
	BCryptPasswordEncoder pwEncoer() {
		return new BCryptPasswordEncoder();
	}
	
	public ModelAndView login(UserVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		session.getAttribute("login");
		UserVO login = dao.pwChk(vo);
		System.out.println("vo.getpw======"+vo.getPw());
		System.out.println("login.getpw======="+login.getPw());
		boolean pwChk = pwEncoder.matches(vo.getPw(), login.getPw());
		
		if(login != null & pwChk == true) {
			session.setAttribute("login", login);
			mav.setViewName("redirect:/"+login.getNickname());
		}
		return mav;
	}
	
	// 회원가입 기능
	public ModelAndView join(UserVO vo) {
		ModelAndView mav = new ModelAndView("redirect:/login");
		
		String enPw = pwEncoder.encode(vo.getPw());
		vo.setPw(enPw);
		
		if(dao.join(vo) != 1) {
			System.out.println("회원가입 실패");
			mav.setViewName("redirect:/");
		}

		return mav;
	}
	
	// 이메일 중복 확인
	public int emailCheck(String email) {
		int chk = dao.emailCheck(email);
		return chk;
	}
	
	// 유저 블로그 가져오기
	public ModelAndView getUsBoard(String nickname) {
		ModelAndView mav = new ModelAndView("userBoard");
		UserVO user = dao.getUser(nickname);
		System.out.println(user.getNickname());
		mav.addObject("user",user);
		return mav;
	}

	

}
