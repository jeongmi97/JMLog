package com.spring.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class UserInterceptor extends HandlerInterceptorAdapter{
	
	// preHandle() 컨트롤러보다 먼저 수행된다
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	        throws Exception {
		
		HttpSession session = request.getSession();		// session 객체 가져옴
		Object obj = session.getAttribute("login");		// 사용자 정보 담고 있는 객체 가져옴
		
		if(obj == null) {		// 로그인 된 세션 없는 경우
			response.sendRedirect("/login");	// 로그인 페이지로 이동
			return false;	// 컨트롤러 요청으로 가지 않도록 false 반환
		}
		// 요청받은 페이지로 이동
		return true;
	}
    
	// postHandle() 컨트롤러가 수행되고 화면이 보여지기 직전에 수행된다
	@Override
	public void postHandle(
			HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
			throws Exception {
	}

}
