package com.spring.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.spring.dao.UserDAO;
import com.spring.vo.UserVO;

public class RememberLoginInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired UserDAO dao;
	
	// 자동로그인
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");	// 해당 사이트의 로그인 쿠키 받아옴
		if(loginCookie != null) {	// 로그인 쿠키가 있을 경우
			System.out.println("login : " + loginCookie.getValue());
			UserVO user = dao.checkUserSession(loginCookie.getValue());	// 로그인 쿠키의 세션키값을 이용해 해당 유저 정보 가져옴
			if(user != null) {	// 해당 유저 있을 경우
				session.setAttribute("login", user);	// 로그인 세션에 저장
			}
		}
		return true;
	}
}
