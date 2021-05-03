package com.spring.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.spring.dao.UserDAO;
import com.spring.vo.BoardVO;
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
		UserVO login = dao.userChk(vo.getEmail());	// 입력한 이메일이 있으면 login객체에 유저 정보 넣기
		System.out.println("로그인 유저 : " + login);
		
		if(login != null) {	// login객체에 유저 정보가 있을 때
			boolean pwChk = pwEncoder.matches(vo.getPw(), login.getPw());	// 입력한 비밀번호 암호화 한 뒤 유저 정보의 비밀번호와 비교
			if(pwChk == true) {	// 비밀번호 일치 시 로그인 실행
				session.setAttribute("login", login);	// login새션에 유저 정보 넣기
				mav.setViewName("redirect:/"+login.getEmail());	// 유저 블로그로 이동
			}
		}else {
			System.out.println("로그인 실패");
			mav.setViewName("redirect:/login");	// 로그인 페이지로 리다이렉트
		}
		
		return mav;
	}
	
	// 회원가입 기능
	public ModelAndView join(UserVO vo) {
		ModelAndView mav = new ModelAndView("redirect:/login");	// 회원가입 성공 시 로그인 페이지로 이동
		
		String enPw = pwEncoder.encode(vo.getPw());	// 입력받은 비밀번호 암호화
		vo.setPw(enPw);	// 암호화 한 비밀번호 유저객체의 비밀번호에 셋팅
		
		if(dao.join(vo) != 1) {	// 유저정보 insert 실패 시
			System.out.println("회원가입 실패");
			mav.setViewName("redirect:/join");	// 회원가입 페이지로 다시 이동
		}
		return mav;
	}
	
	// 이메일 중복 확인
	public int emailCheck(String email) {
		int chk = dao.emailCheck(email);
		return chk;
	}

	// 프로필 설정 페이지 이동
	public ModelAndView setting(HttpSession session) {
		ModelAndView mav = new ModelAndView("setting");
		
		return mav;
	}

	// 카테고리 설정 페이지 이동
	public ModelAndView category(HttpSession session) {
		ModelAndView mav = new ModelAndView("category");
		
		return mav;
	}
	
	
	
}
