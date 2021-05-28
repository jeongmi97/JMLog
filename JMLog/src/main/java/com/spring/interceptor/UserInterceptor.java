package com.spring.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.spring.dao.UserDAO;
import com.spring.vo.UserVO;

public class UserInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired UserDAO dao;
	
	// preHandle() 컨트롤러보다 먼저 수행된다
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
		
		HttpSession session = request.getSession();		// session 객체 가져옴
		Object obj = session.getAttribute("login");		// 사용자 정보 담고 있는 객체 가져옴
		
		if(obj == null) {		// 로그인 된 세션 없는 경우
			// 만들어 놓은 쿠키 가져옴
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if(loginCookie != null) {	// 쿠키 존재 할 때 (이전 로그인 시 생성된 쿠키 존재)
				String sessionid = loginCookie.getValue();	// 로그인 쿠키의 값 꺼내기
				// 이전에 로그인한적이 있는지 체크 후, 유효시간이 지나지 않으면서 sessionid 정보 가지고 있는 사용자 정보 넣기 
				UserVO user = dao.checkUserSession(sessionid);
				
				if(user != null) {	// 사용자 정보 있을 때
					session.setAttribute("login", user);	// 세션 생성
					return true;
				}
			}
			// 로그인x, 쿠키존재x 경우 다시 로그인 페이지로 보내기
			response.sendRedirect("/login");
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
		super.postHandle(request, response, handler, modelAndView);
	}

}
