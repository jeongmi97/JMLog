package com.spring.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dao.UserBoardDAO;
import com.spring.dao.UserDAO;
import com.spring.vo.BoardVO;
import com.spring.vo.CategoryVO;
import com.spring.vo.GuestbookVO;
import com.spring.vo.Pagination;
import com.spring.vo.ReplyVO;
import com.spring.vo.UserVO;

@Service
public class UserBoardService {

	@Autowired UserService us;
	@Autowired UserBoardDAO dao;
	@Autowired UserDAO udao;
	
	// 홈 화면(인기순)
	public ModelAndView home(int page, int range) {
		ModelAndView mav = new ModelAndView("home");
		
		// 페이징 정보 셋팅
		int listCnt = dao.getListCnt();
		
		Pagination pagination = new Pagination();	
		pagination.pageInfo(page, range, listCnt);
		
		mav.addObject("pagination",pagination);
		mav.addObject("postList", dao.getPostList(pagination));
		
		return mav;
	}
	
	// 홈 화면 (최신순)
	public ModelAndView newlist(int page, int range) {
		ModelAndView mav = new ModelAndView("newlist");
		
		// 페이징 정보 셋팅
		int listCnt = dao.getListCnt();
		
		Pagination pagination = new Pagination();	
		pagination.pageInfo(page, range, listCnt);

		mav.addObject("pagination",pagination);
		mav.addObject("postList", dao.getNewPostList(pagination));
		
		return mav;
	}
	
	// 유저 블로그로 이동
	public ModelAndView userBoard(String nickname, HttpSession session, int page, int range, String category) {
		ModelAndView mav = new ModelAndView("userBoard");
		
		System.out.println("넘어온 이메일 : " + nickname);
		String email = dao.getEmail(nickname);
			
		int listCnt = dao.getBoardListCnt(nickname);	// 계정 전체 게시글 개수
			
		if(!category.equals("nocate")) {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("nickname", nickname);
			param.put("cate", category);
			listCnt = dao.getCateBoardList(param);		// 계정 & 카테고리별 게시글 개수
		}
				
		System.out.println("listCnt: " + listCnt + "page&range : " + page + "&" + range);
			
		// 페이징 정보 셋팅
		Pagination pagination = new Pagination();	
		pagination.pageInfo(page, range, listCnt);
			
		HashMap<String, Object> param = new HashMap<String, Object>();	// 해당 계정의 포스트 10개씩 가져오기 위해 param 설정
		param.put("nickname", nickname);
		param.put("cate", category);
		param.put("startList", pagination.getStartList());
		param.put("listSize", pagination.getListSize());
			
		mav.addObject("category", dao.getCategory(email));	// 유저 카테고리 정보 가져오기
		mav.addObject("user", udao.userChk(email));			// 계정 정보 넣기
		
		
		if(session.getAttribute("login") != null) {	// 로그인 중
			UserVO login = (UserVO) session.getAttribute("login");
			if(login.getEmail().equals(email)) {	// 로그인 한 유저가 자신의 게시판에 들어갈 때 비밀글 까지 보이게
				if(category.equals("nocate"))
					mav.addObject("uBoard",dao.userBoardList(param));	// 닉네임, 10
				else
					mav.addObject("uBoard",dao.cateBoardList(param));	// 카테고리 별 보드 리스트
			}
		}else {		// 미로그인
			if(category.equals("nocate"))
				mav.addObject("uBoard",dao.userLockBoardList(param));	// 비밀글 제외 전체 리스트
			else
				mav.addObject("uBoard",dao.cateLockBoardList(param));	// 비밀글 제외 카테고리별 리스트
		}
		
		
		mav.addObject("allCnt", dao.userAllBoardCnt(nickname));
		mav.addObject("pagination",pagination);
		mav.addObject("nowCate", category);
			
		return mav;
	}
		
	// 글쓰기 페이지 이동
	public ModelAndView goWrite(UserVO login) {
		ModelAndView mav = new ModelAndView("write");
		
		mav.addObject("category", dao.getCategory(login.getEmail()));	// 글 생성 시 카테고리 선택을 위한 유저별 카테고리 넘김
		
		return mav;
	}
	
	// 글 쓰기
	public ModelAndView write(BoardVO vo, String mode, UserVO login) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("modeeeeeeeeeeeeeeeeeeee: " + mode);
		System.out.println("닉네임 확인 : " + vo.getNickname());
		System.out.println("비공개 확인 : " + vo.getLock_post());
		
		String nickname = URLEncoder.encode(vo.getNickname(), "UTF-8");	// 닉네임이 한글일 경우 url에 넣을때 깨지지 않게 인코딩 처리함
		
		if(vo.getLock_post() == null)
			vo.setLock_post("n");
		
		int postNum = 0;
		
		HashMap<String, Object>param = new HashMap<String, Object>();
		param.put("email", login.getEmail());
		
		if(mode.equals("edit")) {	// 게시물 수정모드일 때
			String oldcate = dao.getboardCate(vo);
			System.out.println("oldddddddddd : " + oldcate);
			if(!vo.getCate().equals(oldcate)) {	// 카테고리 수정했을 때
				param.put("catename", oldcate);
				dao.minusCateCnt(param);	// 원래 카테고리 개수 -1 하기
			}
			dao.updatePost(vo);		// 게시물 수정
			postNum = vo.getIdx();	// 수정한 게시물 번호
			
		}else {						// 새로운 게시물 생성 시
			if(vo.getLock_post() == null)	// 비공개 선택 안했을 때
				vo.setLock_post("n");		// 비공개 no
			dao.write(vo);			// 게시물 insert
			postNum = dao.getPostnum(vo.getNickname());	// 작성한 게시물 번호
		}
		
		param.put("nickname", vo.getNickname());
		param.put("cate", vo.getCate());
		int cateCnt = dao.getCateCnt(param);	
		System.out.println("카테고리 게시글 개수 : " + cateCnt);
		param.put("catecnt", cateCnt);
		dao.updateCateCnt(param);	// 카테고리별 게시글 개수 update
		
		mav.setViewName("redirect:/"+nickname+"/"+postNum);	// 작성자 이메일/작성(수정)한 게시물번호로 이동
		
		return mav;
	}

	// 게시글 이동
	public ModelAndView viewPost(int idx) {
		ModelAndView mav = new ModelAndView("viewPost");
		
		dao.updateHit(idx);		// 게시글 이동 시 조회수 +1 업데이트
		
		mav.addObject("post",dao.getPost(idx));
		mav.addObject("reply",dao.getReply(idx));
		
		return mav;
	}
	
	// 게시글 수정
	public ModelAndView editPost(int idx, String mode, UserVO login) {
		ModelAndView mav = new ModelAndView("write");
		
		System.out.println("idxxxxxxxxmodeeeee : " + idx + mode);
		
		BoardVO post = dao.getPost(idx);
		mav.addObject("post",post);
		mav.addObject("mode",mode);
		mav.addObject("category",dao.getCategory(login.getEmail()));
		
		return mav;
	}

	// 소개
	public ModelAndView about(String nickname) {
		ModelAndView mav = new ModelAndView("about");
		
		String email = dao.getEmail(nickname);
		mav.addObject("user", udao.userChk(email));			// 계정 정보 넣기
		mav.addObject("content", dao.getAbout(nickname));
		
		return mav;
	}

	// 소개글 작성
	public ModelAndView writeAbout(BoardVO vo) throws Exception {
		ModelAndView mav = new ModelAndView("redirect:/"+vo.getNickname()+"/about");
		
		String nickname = URLEncoder.encode(vo.getNickname(), "UTF-8");
		mav.setViewName("redirect:/"+nickname+"/about");
		
		dao.writeAbout(vo);
		
		
		return mav;
	}
	
	// 소개글 수정
	public ModelAndView updateAbout(BoardVO vo) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		String nickname = URLEncoder.encode(vo.getNickname(), "UTF-8");
		mav.setViewName("redirect:/"+nickname+"/about");
		
		dao.updateAbout(vo);
		
		return mav;
	}
	

	// 게시글 삭제
	public ModelAndView delPost(int idx, UserVO login) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		String nickname = URLEncoder.encode(login.getNickname(), "UTF-8");
		mav.setViewName("redirect:/"+nickname);
		
		dao.delPostReply(idx);
		dao.delPost(idx);	// 외래키 on delete 해결하기
		
		return mav;
	}

	// 댓글 작성
	public void saveReply(ReplyVO reply) {
		dao.saveReply(reply);
	}

	// 댓글 삭제
	public void delReply(int idx) {
		dao.delReply(idx);
	}
	
	// 댓글 인덱스 가져오기
	public int getReplyIdx(String nickname) {
		return dao.getReplyIdx(nickname);
	}

	// 댓글 수정
	public void updateReply(ReplyVO reply) {
		System.out.println("댓글 번호 : "+reply.getIdx()+"댓글 수정 내용 : " + reply.getComment());
		dao.updateReply(reply);
	}
	
	// 카테고리 추가
	public ModelAndView setCategory(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView("redirect:/setting/category");
		
		String[] categorys = req.getParameterValues("catename");
		
		HashMap<String, Object>param = new HashMap<String, Object>();
		param.put("email", req.getParameter("email"));
		param.put("category", categorys);
		
		dao.setCategory(param);
		
		return mav;
	}

	// 카테고리 삭제
	public void delCate(Map<String, Object> param) {
		dao.delCate(param);
		dao.delPostCate(param);
	}
	
	// 카테고리 수정
	public void updateCate(Map<String, Object> param) {
		dao.updateCate(param);
		dao.updatePostCate(param);
	}

	/*
	 * // 스크롤 페이징 public List<BoardVO> getBoardList(int page) { int startList =
	 * ((page-1)*9)+1; return dao.getBoardList(startList); }
	 */

	// 방명록 이동
	public ModelAndView guestbook(String nickname) {
		ModelAndView mav = new ModelAndView("guestbook");
		
		String email = dao.getEmail(nickname);
		
		mav.addObject("user", udao.userChk(email));		// 이동 블로그 유저 정보
		mav.addObject("guestbook", dao.getguestList(email));	// 방명록 리스트 정보
		
		return mav;
	}

	// 방명록 작성
	public ModelAndView insertguest(GuestbookVO vo) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		dao.insertguest(vo);
		
		String nickname = URLEncoder.encode(vo.getNickname(), "UTF-8");
		mav.setViewName("redirect:/"+nickname+"/guestbook");
		
		return mav;
	}

	// 방명록 수정
	public ModelAndView updateguest(GuestbookVO vo) throws UnsupportedEncodingException {
		ModelAndView mav = new ModelAndView();
		
		dao.updateguest(vo);
		
		String nickname = URLEncoder.encode(vo.getNickname(), "UTF-8");
		mav.setViewName("redirect:/"+nickname+"/guestbook");
		
		return mav;
	}

	// 방명록 삭제
	public void delGuest(int idx) {
		dao.delGuest(idx);
	}


}
