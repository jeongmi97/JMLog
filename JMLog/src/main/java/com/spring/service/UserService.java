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
	
	// 비밀번호 암호화 비크립트 사용
	@Autowired BCryptPasswordEncoder pwEncoder;
	// 빈 생성 오류 현상으로 빈 생성 해준 뒤 암호화 실행
	@Bean
	BCryptPasswordEncoder pwEncoer() {
		return new BCryptPasswordEncoder();
	}
	
	// 유저 로그인
	public ModelAndView login(UserVO vo, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		session.getAttribute("login");	// login 새션 생성
		UserVO login = dao.pwChk(vo.getEmail());	// 입력한 이메일이 있으면 login객체에 유저 정보 넣기
		boolean pwChk = pwEncoder.matches(vo.getPw(), login.getPw());	// 입력한 비밀번호 암호화 한 뒤 유저 정보의 비밀번호와 비교
		
		if(login != null & pwChk == true) {	// login객체에 유저 정보가 있고, 비밀번호 체크가 true일 경우
			session.setAttribute("login", login);	// login새션에 유저 정보 넣기
			mav.setViewName("redirect:/"+login.getNickname());	// 유저 블로그로 이동
		}else {
			mav.setViewName("redirect:/");	// 로그인 페이지로 리다이렉트
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
		mav.addObject("user",user);
		return mav;
	}

	

}
