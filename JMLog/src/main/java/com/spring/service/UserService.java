package com.spring.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
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
		UserVO vo = (UserVO) session.getAttribute("login");
		
		mav.addObject("category",dao.getCategory(vo.getEmail()));
		
		return mav;
	}
	
	// 닉네임 중복 확인
	public int nicknameChk(String nickname) {
		return dao.nicknameChk(nickname);	// 입력한 닉네임과 일치하는 닉네임 개수 반환
	}

	// 프로필 수정
	public ModelAndView settingUser(MultipartHttpServletRequest req) {
		ModelAndView mav = new ModelAndView("redirect:/setting");
		
		UserVO vo = new UserVO();
		vo.setEmail(req.getParameter("email"));
		vo.setNickname(req.getParameter("nickname"));
		
		MultipartFile mfile = req.getFile("profileimg");
		
		String imgType = mfile.getContentType();
		
		if(req.getFile("profileimg") != null) {	// 이미지 파일 선택 했을 때
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
		
		dao.setNickname(vo);
		
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

	// 카테고리 추가
	public ModelAndView setCategory(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("redirect:/category");
		
		String[] categorys = req.getParameterValues("catename");
		
		HashMap<String, Object>param = new HashMap<String, Object>();
		param.put("email", req.getParameter("email"));
		param.put("category", categorys);
		
		dao.setCategory(param);
		
		return mav;
	}
	
	
}
