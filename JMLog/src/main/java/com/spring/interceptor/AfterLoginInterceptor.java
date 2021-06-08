package com.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AfterLoginInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 로그인 후 로그인 페이지 or 회원가입 페이지 이동 할 경우
		HttpSession session = request.getSession();
		if(session.getAttribute("login") != null) {	// 로그인 세션 있을 경우
			response.sendRedirect("/home");	// 홈으로 보냄
			return false;
		}
		return true;	// 없으면 요청한 페이지로 이동
	}
}
