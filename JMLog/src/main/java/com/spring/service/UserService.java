package com.spring.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.spring.dao.UserDAO;
import com.spring.vo.UserVO;

@Service
public class UserService {

	@Autowired UserDAO dao;
	
	// 비밀번호 암호화 비크립트 사용
	@Autowired BCryptPasswordEncoder pwEncoder;
	
	// 유저 로그인
	public ModelAndView login(UserVO vo, HttpSession session, HttpServletRequest req, HttpServletResponse res) throws IOException {
		ModelAndView mav = new ModelAndView();
		
		boolean pwChk = false;	// 비밀번호 일치 확인 변수 (일치 : true / 불일치 : false)
		
		if(session.getAttribute("login") != null) {
			session.removeAttribute("login");	// 기존에 login 세션 존재할 시 기존값 제거
		}
		
		// 입력한 이메일이 있으면 login객체에 유저 정보 넣기
		UserVO login = dao.userChk(vo.getEmail());	
		
		if(login != null)	
			pwChk = pwEncoder.matches(vo.getPw(), login.getPw());	// 입력한 비밀번호 암호화 한 뒤 유저 정보의 비밀번호와 비교
		
		if(login == null || pwChk == false) {	// login객체가 비어있거나 pwChk가 false일 때 (로그인 실패)
			res.setContentType("text/html; charset=UTF-8");
			PrintWriter out = res.getWriter();
			out.println("<script>alert('이메일/비밀번호를 확인해 주세요'); history.go(-1);</script>");	// 알림창 띄운 뒤 다시 로그인 페이지로 이동하게 한다
			out.close();
		}
		if(login != null && pwChk == true) {	// login 객체가 존재하고 pwChk가 true일 때 (로그인 성공)
			session.setAttribute("login", login);	// login새션에 유저 정보 넣기
			if(req.getParameter("useCookie") != null) {		// 로그인 유지에 체크 했을 때
				// 쿠키 생성, 로그인할때 생성된 세션의 id 쿠키에 저장
				int amount = 60 * 60 * 24 * 7;	// 7일
				Cookie loginCookie = new Cookie("loginCookie", session.getId());
				loginCookie.setPath("/");
				loginCookie.setMaxAge(amount);
				res.addCookie(loginCookie);
				Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));	// 로그인 유지기간 설정
				HashMap<String, Object>param = new HashMap<String, Object>();
				param.put("email", vo.getEmail()); param.put("sessionid", session.getId()); param.put("sessionLimit", sessionLimit);
				dao.keepLogin(param);
			}
			mav.setViewName("redirect:/");		// home 페이지로 이동
		}
		return mav;
	}
	
	// 로그아웃
	public ModelAndView logout(HttpSession session, HttpServletRequest req, HttpServletResponse res) {
		ModelAndView mav = new ModelAndView("redirect:/");	// 로그아웃 한 뒤 메인 페이지로 이동
		Object obj = session.getAttribute("login");	
		if(obj != null) {	// 로그인 세션 존재 시
			UserVO user = (UserVO) obj;
			session.removeAttribute("login");	// 세션 제거
			session.invalidate();
			// 현재 브라우저의 자동 로그인 쿠키 가져옴
			Cookie loginCookie = WebUtils.getCookie(req, "loginCookie");
			if(loginCookie != null) {	// 자동로그인 시 생성된 로그인 쿠키 있으면 해당 쿠키 삭제
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				res.addCookie(loginCookie);
				HashMap<String , Object>param = new HashMap<String, Object>();
				// sessionid는 null, sessionLimit는 현재 시간으로 설정한다
				param.put("email", user.getEmail()); param.put("sessionid", null); param.put("sessionLimit", new java.util.Date());
				dao.keepLogin(param);
			}
		}
		return mav;
	}
	
	// 회원가입 기능
	public ModelAndView join(UserVO vo) {
		ModelAndView mav = new ModelAndView("redirect:/login");	// 회원가입 성공 시 로그인 페이지로 이동
		
		String enPw = pwEncoder.encode(vo.getPw());	// 입력받은 비밀번호 암호화
		vo.setPw(enPw);	// 암호화 한 비밀번호 유저객체의 비밀번호에 셋팅
		
		if(dao.join(vo) != 1) {	// 유저정보 insert 실패 시
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
	public String nicknameChk(String nickname) {
		return dao.nicknameChk(nickname);	// 입력한 닉네임과 일치하는 닉네임 개수 반환
	}

	// 프로필 수정
	public ModelAndView settingUser(MultipartHttpServletRequest req) {
		ModelAndView mav = new ModelAndView("/setting");
		
		UserVO vo = new UserVO();
		vo.setEmail(req.getParameter("email"));
		vo.setNickname(req.getParameter("nickname"));
		
		String imgChk = req.getParameter("imgChk");		// 파일 선택 안했을 때 no 들어옴
		
		MultipartFile mfile = req.getFile("profileimg");// 이미지 파일 데이터
		String imgType = mfile.getContentType();		// 이미지 파일 확장자
		
		// 이미지 파일 선택 했거나(yes) 파일 데이터가 null이 아니면
		if(imgChk.equals("yes") && mfile != null) {	
			try {
				// 이메일 일치하는 유저의 프로필 사진 업데이트
				HashMap<String, Object>param = new HashMap<String, Object>();
				param.put("email", vo.getEmail());
				param.put("img", mfile.getBytes());	// byte 데이터 map 형식으로 넣으면 blob 컬럼에 그냥 들어가진다
				param.put("imgtype", imgType);
				dao.setProfileImg(param);	// 유저 이미지 업데이트 쿼리 실행
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		String oldnickname = dao.getNickname(vo.getEmail());	// 수정 전 닉네임
		HashMap<String, String>param = new HashMap<String, String>();
		param.put("oldnickname", oldnickname);
		param.put("nickname", vo.getNickname());
		dao.setNickname(vo);	// 닉네임 수정
		dao.updatePostNickname(param);
		dao.updateReplyNickname(param);
		
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

	// 회원탈퇴
	public void deluser(String nickname, HttpSession session) {
		
		UserVO login = (UserVO) session.getAttribute("login");
		
		if(login != null) {		// 로그인 중인 세션 없애기
			session.removeAttribute("login");
			session.invalidate();
		}
		
		// 탈퇴하는 유저와 관련된 데이터 삭제
		dao.delUserReply(nickname);
		dao.delUserBoard(nickname);
		dao.deluser(nickname);
	}

}
