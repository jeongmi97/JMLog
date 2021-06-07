package com.spring.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.spring.dao.UserDAO;
import com.spring.vo.BoardVO;
import com.spring.vo.CategoryVO;
import com.spring.vo.UserVO;

@Service
public class UserService {

	@Autowired UserDAO dao;
	
	// 비밀번호 암호화 비크립트 사용
	@Autowired BCryptPasswordEncoder pwEncoder;
	
	// 유저 로그인
	public ModelAndView login(UserVO vo, HttpSession session, HttpServletRequest req, HttpServletResponse res) throws IOException {
		ModelAndView mav = new ModelAndView();
		
		if(session.getAttribute("login") != null) {
			session.removeAttribute("login");	// 기존에 login 세션 존재할 시 기존값 제거
		}
		
		// 입력한 이메일이 있으면 login객체에 유저 정보 넣기
		UserVO login = dao.userChk(vo.getEmail());	
		System.out.println("로그인 유저 : " + login);
		System.out.println("로그인유지 체크 ::::: " + req.getParameter("useCookie"));
		
		boolean pwChk = pwEncoder.matches(vo.getPw(), login.getPw());	// 입력한 비밀번호 암호화 한 뒤 유저 정보의 비밀번호와 비교
		
		if(login == null || pwChk == false) {	// login객체가 비어있거나 비밀번호 비교가 안맞을 경우 (로그인 실패)
			res.setContentType("text/html; charset=UTF-8");
			PrintWriter out = res.getWriter();
			out.println("<script>alert('이메일/비밀번호를 확인해 주세요'); history.go(-1);</script>");	// 알림창 띄운 뒤 다시 로그인 페이지로 이동하게 한다
			out.close();
		}
		if(login != null && pwChk == true) {	// 로그인 성공
			session.setAttribute("login", login);	// login새션에 유저 정보 넣기
			System.out.println("프로필 이미지 체크 :::: " + login.getProfileimg());
			if(req.getParameter("useCookie") != null) {		// 로그인 유지에 체크 했을 때
				System.out.println("cookie");
				// 쿠키 생성, 로그인할때 생성된 세션의 id 쿠키에 저장
				Cookie loginCookie = new Cookie("loginCookie", session.getId());
				loginCookie.setPath("/");	// 쿠키 찾을 경로 전체 경로로 변경
				int amount = 60 * 60 * 24* 7;
				loginCookie.setMaxAge(amount);	// 7일 유효시간 설정
				res.addCookie(loginCookie);	// 쿠키 적용
				// currentTimeMills()가 1/1000초 단위로 1000곱해서 더해야 한다
				Date sessionlimit = new Date(System.currentTimeMillis() + (1000*amount));
				HashMap<String, Object>param = new HashMap<String, Object>();
				param.put("email", login.getEmail());
				param.put("sessionid", session.getId());
				param.put("sessionlimit", sessionlimit);
				// 현재 세션 id와 유효시간을 사용자 테이블에 저장
				dao.keepLogin(param);
			}
			//mav.setViewName("redirect:/"+login.getEmail());	// 유저 블로그로 이동
			mav.setViewName("redirect:/");		// home 페이지로 이동
		}
		
		return mav;
	}
	
	// 로그아웃
	public ModelAndView logout(HttpSession session, HttpServletRequest req, HttpServletResponse res) {
		ModelAndView mav = new ModelAndView("redirect:/");
		
		req.getSession().removeAttribute("login");
		
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
		return dao.emailCheck(email);	// 입력한 이메일과 일치하는 이메일 개수 반환
	}

	// 프로필 설정 페이지 이동
	public ModelAndView setting(HttpSession session) {
		ModelAndView mav = new ModelAndView("setting");
		
		return mav;
	}

	// 카테고리 설정 페이지 이동
	public ModelAndView category(HttpSession session) {
		ModelAndView mav = new ModelAndView("category");
		UserVO vo = (UserVO) session.getAttribute("login");
		
		mav.addObject("category",dao.getCategory(vo.getEmail()));	// 유저의 카테고리 정보 넣어주기
		
		return mav;
	}
	
	// 닉네임 중복 확인
	public int nicknameChk(String nickname) {
		return dao.nicknameChk(nickname);	// 입력한 닉네임과 일치하는 닉네임 개수 반환
	}

	// 프로필 수정
	public ModelAndView settingUser(MultipartHttpServletRequest req) {
		ModelAndView mav = new ModelAndView("/setting");
		
		UserVO vo = new UserVO();
		vo.setEmail(req.getParameter("email"));
		vo.setNickname(req.getParameter("nickname"));
		
		String imgChk = req.getParameter("imgChk");		// 파일 선택 안했을 때 no 들어옴
		
		MultipartFile mfile = req.getFile("profileimg");
		System.out.println("이미지 :::: "  + mfile);
		String imgType = mfile.getContentType();
		System.out.println("이미지선택 체크 : " + req.getParameter("imgChk"));
		if(imgChk == "yes" && mfile != null) {	// 이미지 파일 선택 했을 때
			System.out.println("이미지 수정 들어옴");
			try {
				mfile = req.getFile("profileimg");
				// 이메일 일치하는 유저의 프로필 사진 업데이트
				HashMap<String, Object>param = new HashMap<String, Object>();
				param.put("email", vo.getEmail());
				param.put("img", mfile.getBytes());	// byte 데이터 map 형식으로 넣으면 blob 컬럼에 그냥 들어가진다
				param.put("imgtype", mfile.getContentType());	// 파일 확장자
				dao.setProfileImg(param);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		dao.setNickname(vo);	// 닉네임 수정
		
		return mav;	// 수정 완료하고 다시 setting 화면으로 돌아감
	}

	// 프로필 이미지 가져오기
	public ResponseEntity<byte[]> getProfileImg(String email) {
		// 이메일 이용해서 프로필 이미지 데이터와 확장자 map형식으로 가져오기
		Map<String, Object> map = dao.getProfileImg(email);
		byte[] profileImg = (byte[])map.get("profileimg");
		
		// 파일을 클라이언트로 전송하기 위해 전송정보 담을 헤더 설정
		final HttpHeaders headers = new HttpHeaders();
		String type = (String)map.get("imgtype");
		String[] types = type.split("/");
		
		// 전송헤더에 파일정보와 확장자 셋팅
		headers.setContentType(new MediaType(types[0],types[1]));
		
		return new ResponseEntity<byte[]>(profileImg, headers, HttpStatus.OK);
	}

}
