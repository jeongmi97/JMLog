# JMLog
> http://15.165.184.233:8080/<br>
> *서버 중지 상태 시 사이트 접속이 안 될 수 있습니다.*
------------
## 프로젝트 계획
> 웹 프로그래밍의 기본적인 CRUD 기능을 공부하기위해 이번 프로젝트를 계획하였습니다. CRUD 기능을 가장 잘 사용할 수 있는 블로그라는 주제를 선택하였고, 평소 자주 들어가는 사이트중 [velog](https://velog.io/)와 티스토리 블로그를 참고하였습니다. 프로젝트 계획을 하면서 단순한 혼자만의 게시판 관리가 아닌 유저간의 교류가 가능한 블로그 플랫폼을 만들기 위해 aws에 배포 후 다른 유저들과의 테스트까지 진행한 뒤 프로젝트를 완성하였습니다.
## 프로젝트 소개
1.프로젝트 기능

  * CREATE
 
    * 회원가입
    * 게시글작성 기능
    * 게시글에 대한 댓글 작성 기능
    * 새로운 카테고리 추가 기능
    * 방명록 작성 기능
    * 짧은 자기 소개글 작성 기능
  * READ

    * 플랫폼 메인 페이지 인기순(조회수) OR 최신순으로 비밀글 제외 모든 유저 게시글 리스트 조회 기능
    * 블로그 페이지 최신순 OR 카테고리별 비밀글 포함 게시글 리스트 조회 기능(자신의 블로그)
    * 블로그 페이지 최신순 OR 카테고리별 비밀글 제외 게시글 리스트 조회 기능(비회원 & 다른 유저 블로그)
    * 선택한 게시글 조회 기능
  * UPDATE

    * 게시글의 카테고리와 내용 수정하는 기능
    * 댓글 수정 기능
    * 방명록 수정 기능
    * 소개글 수정 기능
    * 카테고리명 수정 기능
    * 프로필 이미지 업로드 기능
    * 닉네임 변경 기능
  * DELETE

    * 게시글 삭제 기능
    * 댓글 삭제 기능
    * 방명록 삭제 기능
    * 소개글 삭제 기능
    * 카테고리 삭제 기능
    * 프로필 이미지 삭제 기능
    * 회원 탈퇴 기능
   
2. 개발환경<br><br>
<strong>OS</strong> : Window10, Linux<br>
<strong>Language</strong> : Java, JavaScript , HTML5, CSS<br>
<strong>Framework & Library</strong> : Spring, MyBatis, Bootstrap, jQuery<br>
<strong>DataBase</strong> : MySQL, MySQL Workbench<br>
<strong>aws</strong> : RDS, EC2

## 프로젝트 구성
### 데이터베이스 테이블 설계<br>
 ![ERD](https://user-images.githubusercontent.com/67229566/121874157-104dc580-cd42-11eb-91e8-447636c51b27.PNG)<br>
 <sub>테이블 설계서</sub><br>
   **user** : 회원가입한 유저들을 관리하는 user테이블은 *email*과 *nickname*을 기본키로 설정해 중복을 방지하고 각 유저를 구분해 다른 테이블과의 관계설정에 쓰입니다. 프로필 이미지의 데이터를 저장하기위해 *profileimg*를 longblob타입으로 설정하였고 *imgtype*은 파일 확장자를 저장합니다. 자동로그인 수행 시 필요한 *sessionkey*와 *sessionlimit*는 로그인세션id와 세션기간을 저장합니다. *pw*는 비밀번호, *reservedate*는 가입일을 나타냅니다.<br>
 **board** : 게시물 테이블입니다. *idx*는 게시글 번호로 기본키로 설정되어있습니다. *nickname*은 user테이블의 nickname을 참조하고있습니다. *cate*는 카테고리이름으로 category테이블의 catename을 참조합니다. *title*은 제목, *content*는 내용, *reportin_date*는 작성일, *hit*는 조회수, *lock_post*는 비밀글 체크 여부를 저장하며 {a : 소개글, n : 공개글, y : 비밀글}의 세 값을 가지게 됩니다.<br>
 **reply** : 게시글에 대한 댓글 테이블입니다. *idx*는 댓글 번호로 기본키로 설정되어있습니다. *post_num*은 board테이블의 idx를 참조하며, *nickname*은 user테이블의 nickname을 참조하고있습니다. *comment*는 댓글내용, *reply_date*는 댓글 작성일을 나타냅니다.<br>
 **category** : 카테고리를 설정하는 테이블입니다. *idx*와 *catename*은 카테고리 번호와 카테고리명으로 기본키 설정이 되어있습니다. *email*은 user테이블의 email을 참조합니다. *catecnt*는 카유저의 테고리별 게시글 개수를 나타냅니다.<br>
 **guestbook** : 방명록 테이블입니다. *idx*는 글 번호로 기본키 설정되어있습니다. *email*은 블로그의 주인으로 user테이블의 email을 참조하고 있으며, *nickname*은 작성자로 user테이블의 nickname을 참조하고있습니다.
### 주요 기능
1. 메인화면
> 메인 홈페이지 화면으로 인기순과 최신순으로 리스트를 확인할 수 있습니다.
 ![홈화면](https://user-images.githubusercontent.com/67229566/121815998-11d0ac80-ccb4-11eb-916d-fd903ec87198.PNG)
> > **UserBoardMapper.xml**
>	> ```xml
>	> <!-- 메인 페이지 리스트 가져오기 (인기순) -->
> >	<select id="getPostList" parameterType="Pagination" resultType="BoardVO">
> >		select *
> >		from board
> >		where not lock_post in ('a', 'y')
> >		order by hit desc limit #{startList}, #{listSize}
> >	</select>
> >	
> >	<!-- 메인 페이지 리스트 가져오기 (최신순) -->
> >	<select id="getNewPostList" parameterType="Pagination" resultType="BoardVO">
> >		select *
> >		from board
> >		where not lock_post in ('a', 'y')
> >		order by idx desc limit #{startList}, #{listSize}
> >	</select>
> >	```
> 상단의 header에는 클릭시 메인화면으로 이동하는 프로젝트 이름과 비회원의 경우 로그인 버튼, 로그인 중 일 경우 글쓰기 버튼과 클릭시 드롭다운 메뉴가 표시되는 프로필 이미지가 보여집니다.
 ![로그인중](https://user-images.githubusercontent.com/67229566/121816142-d71b4400-ccb4-11eb-8644-445bbaa23576.PNG)
> > **header.jsp**
> > ```html
> > <div class="row mt-2">
> >	<div class="col-md-8" style="margin-top: 10px"><h2><a href="${cpath }/">JMLog</a></h2></div>
> >	<c:choose>
> >		<c:when test="${not empty login }">		<!-- 로그인 되어있을 때 -->
> >			<div class="col-md-3 text-right" style="margin-top: 20px">
> >				<button type="button" class="btn btn-dark" style="margin-left: 5px; margin-right: 5px" onclick="location.href='${cpath}/write'">새글쓰기</button>
> >			</div>
> >			<div class="col-md-1 text-right" style="margin-top: 20px">
> >				<a href="#" class="dropdown-toggle" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true" >
> >				<div class="profile" style="background: #BDBDBD; margin-right: 0px">
> >					<c:choose>
> >						<c:when test="${login.profileimg != null }">
> >							<!-- img태그의 src 경로는 profileImg 가져오는 컨트롤러 호출함(/email/getProfileImg) -->
> >							<img class="img" src="${cpath }/${login.email}/getProfileImg">
> >						</c:when>
> >						<c:otherwise>
> >							<img class="img" src="${cpath }/resources/img/default.jpg">
> >						</c:otherwise>
> >					</c:choose>
> >				</div>
> > 					<!-- 드롭다운 메뉴 -->
> >					<span class="caret"></span></a>
> >					<ul class="dropdown-menu justify-content-end" role="menu" aria-labelledby="dropdownMenu1">
> >						<li role="presentation"><a role="menuitem" tabindex="-1" href="${cpath }/${login.nickname}">내 로그</a></li>
> >						<li role="presentation"><a role="menuitem" tabindex="-1" href="${cpath }/setting">설정</a></li>
> >						<li role="presentation"><a role="menuitem" tabindex="-1" href="${cpath }/logout">로그아웃</a></li>
> >					</ul>
> >			</div>
> >		</c:when>
> >		<c:otherwise>	<!-- 로그인 안 돼 있을 때 -->
> >			<div class="col-md-4 text-right" style="margin-top: 20px"><button type="button" class="btn btn-dark" onclick="location.href='${cpath}/login'">로그인</button></div>
> >		</c:otherwise>
> >	</c:choose>
> ></div>
> >```
2. 회원가입
> 제약조건에 맞지 않는 입력값이 있을 경우 회원가입을 할 수 없습니다.
> ![회원가입no](https://user-images.githubusercontent.com/67229566/121816898-4a26b980-ccb9-11eb-9bf2-08940c0c1a24.PNG)
> > **join.js**
> > ```js
> > // 이메일 & 비밀번호 정규표현식
> >	const patternEmail = RegExp(/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/);
> >	// 영문자 숫자 조합 8자 이상
> >	const patternPw = RegExp(/^(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/);	
> >	
> >	// 입력값 제약조건 확인 배열 [이메일, 비밀번호, 비밀번호 확인, 닉네임]
> >	var btnChk = ['n', 'n', 'n', 'n'];
> >	
> >	$(document).ready(function(){
> >	
> >	// 각 입력값의 경고 텍스트 숨김
> >	$('.alert').hide();
> >		
> >	// 이메일 정규표현식 확인 & 중복체크
> >	$('#email').blur(function() {
> >		const email = $('#email').val();
> >		var idmsg = $('#idmsg');
> >		
> >		if(email == ''){	// 이메일 미입력 시
> >			idmsg.text("이메일을 입력해주세요");
> >			return;
> >		}else if(!patternEmail.test(email)){	// 이메일 정규표현식에 맞지 않을 때
> >			idmsg.text("이메일 형식에 맞게 입력해주세요");
> >			btnChk[0] = 'n';
> >			$('#idmsgAlert').show();
> >			return;
> >		}else{		// 이메일 정규표현식에 맞을 경우 ajax를 통해 계정 중복 테스트
> >			$.ajax({
> >				// 데이터를 get 방식으로 url에 붙여 전송
> >				type: "GET",
> >				url: 'emailCheck?email='+email,
> >				success: function(data){
> >					// return값을 int값으로 받아와 select된 계정이 1개 이상이면 사용중인 계정
> >					if(data > 0){
> >						idmsg.text('이미 사용중인 계정입니다');
> >						$('#idmsgAlert').show();	// 경고 텍스트 나타냄
> >						btnChk[0] = 'n';			// 제약조건 확인배열에 no값 넣는다
> >					}else{
> >						$('#idmsgAlert').hide();	// 경고 텍스트 숨김
> >						btnChk[0] = 'y';			// 제약조건 확인배열에 yes값 넣는다
> >					}
> >				}
> >			})
> >		}
> >	});
> >	... 생략 ...
> >	// 인풋값들이 제약조건에 모두 성립 시 가입하기 버튼 활성화
> >	function btnchk(){	
> >		var check = 'y';	// 제약조건 체크 변수
> >		for(var i=0; i<4; i++){
> >			if(btnChk[i] == 'n')	// 배열에 n 값이 있으면
> >				check = 'n';		// 체크변수에 n 넣음
> >		}
> >		if(check == 'y')			// 체크변수가 y일 때
> >			$('form').submit();		// 회원가입 폼 전송
> >		else{
> >			alert('입력정보를 확인해주세요!');	// 알림 나타낸 후
> >			return;						// return
> >		}
> >	}
> >	```
> 회원가입 기능이 실행되고 user 정보를 insert할 때 비밀번호는 Bycrypt로 암호화 되어 저장됩니다.
> > bcrypt를 사용하기 위해 spring security 의존성 주입과 root-context파일에 파라미터 추가<br>
> > **pom.xml**
> > ```xml
> > <!-- Spring Security web 라이브러리-->
> >		<dependency>
> >    		<groupId>org.springframework.security</groupId>
> >    		<artifactId>spring-security-web</artifactId>
> >    		<version>4.2.1.RELEASE</version>
> >  		</dependency>
> > 		<!-- Spring Security core 라이브러리-->
> >  		<dependency>
> >    		<groupId>org.springframework.security</groupId>
> >    		<artifactId>spring-security-core</artifactId>
> >    		<version>4.2.1.RELEASE</version>
> >  		</dependency>
> >  		<!-- Spring Security config 라이브러리-->
> >  		<dependency>
> >    		<groupId>org.springframework.security</groupId>
> >    		<artifactId>spring-security-config</artifactId>
> >    		<version>4.2.1.RELEASE</version>
> >		</dependency>
> > ```
> > **root-context.xml**
> > ```xml
> > <!-- Security --> 
> >	<bean id="pwEncoder" class="org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder" />
> > ```
> > **UserService.java**
> > ```java
> > // 비밀번호 암호화 비크립트 사용
> >	@Autowired BCryptPasswordEncoder pwEncoder;
> >	// 회원가입 기능
> >	public ModelAndView join(UserVO vo) {
> >		ModelAndView mav = new ModelAndView("redirect:/login");	// 회원가입 성공 시 로그인 페이지로 이동
> >		
> >		String enPw = pwEncoder.encode(vo.getPw());	// 입력받은 비밀번호 암호화
> >		vo.setPw(enPw);	// 암호화 한 비밀번호 유저객체의 비밀번호에 셋팅
> >		
> >		if(dao.join(vo) != 1) {	// 유저정보 insert 실패 시
> >			mav.setViewName("redirect:/join");	// 회원가입 페이지로 다시 이동
> >		}
> >		return mav;
> >	}
> >	``` 
3. 로그인
> 로그인 시 로그인 유지를 체크하면 다음번 접속 시 자동으로 로그인됩니다.<br>
> *비밀번호 찾기는 구현 예정입니다*
> ![로그인](https://user-images.githubusercontent.com/67229566/121816896-45fa9c00-ccb9-11eb-8a5e-3df775188db5.PNG)
> > **UserService.java**
> > ```java
> > // 유저 로그인
> >	public ModelAndView login(UserVO vo, HttpSession session, HttpServletRequest req, HttpServletResponse res) throws IOException {
> >		ModelAndView mav = new ModelAndView();
> >		
> >		boolean pwChk = false;	// 비밀번호 일치 확인 변수 (일치 : true / 불일치 : false)
> >		
> >		if(session.getAttribute("login") != null) {
> >			session.removeAttribute("login");	// 기존에 login 세션 존재할 시 기존값 제거
> >		}
> >		
> >		// 입력한 이메일이 있으면 login객체에 유저 정보 넣기
> >		UserVO login = dao.userChk(vo.getEmail());	
> >		
> >		if(login != null)	
> >		pwChk = pwEncoder.matches(vo.getPw(), login.getPw());	// 입력한 비밀번호 암호화 한 뒤 유저 정보의 비밀번호와 비교
> >	
> >		if(login == null || pwChk == false) {	// login객체가 비어있거나 pwChk가 false일 때 (로그인 실패)
> >			res.setContentType("text/html; charset=UTF-8");
> >			PrintWriter out = res.getWriter();
> >			out.println("<script>alert('이메일/비밀번호를 확인해 주세요'); history.go(-1);</script>");	// 알림창 띄운 뒤 다시 로그인 페이지로 이동하게 한다
> >			out.close();
> >		}
> >		if(login != null && pwChk == true) {	// login 객체가 존재하고 pwChk가 true일 때 (로그인 성공)
> >			session.setAttribute("login", login);	// login새션에 유저 정보 넣기
> >			if(req.getParameter("useCookie") != null) {		// 로그인 유지에 체크 했을 때
> >				// 쿠키 생성, 로그인할때 생성된 세션의 id 쿠키에 저장
> >				int amount = 60 * 60 * 24 * 7;	// 7일
> >				Cookie loginCookie = new Cookie("loginCookie", session.getId());
> >				loginCookie.setPath("/");
> >				loginCookie.setMaxAge(amount);
> >				res.addCookie(loginCookie);
> >				Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));	// 로그인 유지기간 설정
> >				HashMap<String, Object>param = new HashMap<String, Object>();
> >				param.put("email", vo.getEmail()); param.put("sessionid", session.getId()); param.put("sessionLimit", sessionLimit);
> >				dao.keepLogin(param);
> >			}
> >			mav.setViewName("redirect:/");		// home 페이지로 이동
> >		}
> >		return mav;
> >	}
> > ```
>  세션아이디와 7일의 시간이 user 테이블에 저장됩니다.
> > **UserMapper.xml**
> > ```xml
> > <!-- 로그인 유지 세션 내용 저장 -->
> >	<update id="keepLogin" parameterType="HashMap">
> >		update user
> >		set sessionkey=#{sessionid}, sessionlimit=#{sessionLimit}
> >		where email=#{email}
> >	</update>
> > ```
> > ![세션확인](https://user-images.githubusercontent.com/67229566/121818285-28c9cb80-ccc1-11eb-8848-7e9f3a9c499c.PNG)
> > 
> 자동로그인을 위한 인터셉터 파일 작업을 해줍니다.
> > **RememberLoginInterceptor.java**
> > ```java
> > // 자동로그인
> >	@Override
> >	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
> >			throws Exception {
> >		HttpSession session = request.getSession();
> >		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");	// 해당 사이트의 로그인 쿠키 받아옴
> >		if(loginCookie != null) {	// 로그인 쿠키가 있을 경우
> >			UserVO user = dao.checkUserSession(loginCookie.getValue());	// 로그인 쿠키의 세션키값을 이용해 해당 유저 정보 가져옴
> >			if(user != null) {	// 해당 유저 있을 경우
> >				session.setAttribute("login", user);	// 로그인 세션에 저장
> >			}
> >		}
> >		return true;
> >	}
> > ```
> > **servelet-context.xml**
> > ```xml
> > <!-- 인터셉터 빈 등록 -->
> > <beans:bean id="RememberLoginInterceptor" class="com.spring.interceptor.RememberLoginInterceptor" />
> > <!-- 인터셉터 호출 위한 url mapping -->
> > <interceptors>
> > 	<!-- 로그인쿠키 확인 후 자동로그인 실행 -->
> > 	<interceptor>
> >			<mapping path="/**/"/>
> >			<beans:ref bean="RememberLoginInterceptor"/>
> >		</interceptor>
> > ```
4. 로그아웃
> 로그아웃 시 로그인세션 뿐 아니라 자동로그인을 위해 생성된 쿠키 여부도 체크 후 삭제합니다.
> > **UserService.java**
> > ```java
> > // 로그아웃
> >public ModelAndView logout(HttpSession session, HttpServletRequest req, HttpServletResponse res) {
> >	ModelAndView mav = new ModelAndView("redirect:/");	// 로그아웃 한 뒤 메인 페이지로 이동
> >	Object obj = session.getAttribute("login");	
> >	if(obj != null) {	// 로그인 세션 존재 시
> >		UserVO user = (UserVO) obj;
> >		session.removeAttribute("login");	// 세션 제거
> >		session.invalidate();
> >		// 현재 브라우저의 자동 로그인 쿠키 가져옴
> >		Cookie loginCookie = WebUtils.getCookie(req, "loginCookie");
> >		if(loginCookie != null) {	// 자동로그인 시 생성된 로그인 쿠키 있으면 해당 쿠키 삭제
> >			loginCookie.setPath("/");
> >			loginCookie.setMaxAge(0);
> >			res.addCookie(loginCookie);
> >			HashMap<String , Object>param = new HashMap<String, Object>();
> >			// sessionid는 null, sessionLimit는 현재 시간으로 설정한다
> >			param.put("email", user.getEmail()); param.put("sessionid", null); param.put("sessionLimit", new java.util.Date());
> >			dao.keepLogin(param);
> >		}
> >	}
> >	return mav;
> >}
> > ```
> > <sub>null값과 현재시간으로 설정된 sessionkey와 sessionlimit 컬럼</sub>
> > ![로그아웃세션](https://user-images.githubusercontent.com/67229566/121923360-cf6fa400-cd75-11eb-89b4-26c8f32841d1.PNG)
>
5.게시글
> 게시글 작성 시 유저가 만들어놓은 카테고리를 설정할 수 있고, 비공개 체크 시 비밀글로 작성이 되어 작성한 유저만 해당 글을 볼 수 있습니다.
> 게시글 작성이 완료되면 바로 작성한 글 열람 페이지로 이동합니다.
>![글쓰기](https://user-images.githubusercontent.com/67229566/121847819-2187d980-cd24-11eb-8bd2-9e6c8a699233.PNG)
> > 내용을 좀더 편리하게 작성할 수 있도록 부트스트랩을 기반으로 둔 웹 에디터인 썸머노트를 CDN방식으로 적용하였습니다.
> > **write.jsp**
> > ```html
> > <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet"> 
> > <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
> > <script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
> > ... 생략 ...
> > <form:form method="post" modelAttribute="post" action="${cpath }/write">
> >		<form:hidden path="idx"/>	<!-- 포스트 번호 -->
> >		<form:hidden path="nickname" value="${login.nickname }"/>	<!-- 작성자 닉네임 -->
> >		<input type="hidden" name="mode" value="${mode }">	<!-- 신규 생성 & 수정 확인 값 -->
> >		
> >		<!-- 카테고리 선택 -->
> >		<form:select path="cate" id="category">
> >			<option value="nocate">카테고리</option>
> >			<form:options items="${category }" itemLabel="catename" itemValue="catename"/>
> >		</form:select>
> >		<form:input path="title" type="text" name="title" id="title" placeholder="제목을 입력하세요" required="required"/>
> >		<form:textarea path="content" class="summernote" name="content" id="content" rows="40" required="required" /><br>
> >		<form:checkbox path="lock_post" value="y" name="lock_post" id="lock_post"/><label for="lock_post">비공개</label>
> >		<input type="submit" value="작성하기">
> >	</form:form>
> > ```
> 게시글 생성이나 수정모드를 확인하여 각각 다른 메소드들을 실행합니다.
> > **UserBoardService.java**
> > ```java
> > // 글 쓰기
> >	public ModelAndView write(BoardVO vo, String mode, UserVO login) throws Exception {
> >		ModelAndView mav = new ModelAndView();
> >		
> >		String nickname = URLEncoder.encode(vo.getNickname(), "UTF-8");	// 닉네임이 한글일 경우 url에 넣을때 깨지지 않게 인코딩 처리함
> >		
> >		if(vo.getLock_post() == null)	// 비공개 체크 안했을 때
> >			vo.setLock_post("n");		// 비공개 no
> >		
> >		int postNum = 0;
> >		
> >		HashMap<String, Object>param = new HashMap<String, Object>();
> >		param.put("email", login.getEmail());
> >		
> >		if(mode.equals("edit")) {	// 게시물 수정모드일 때
> >			String oldcate = dao.getboardCate(vo);
> >			if(!vo.getCate().equals(oldcate)) {	// 카테고리 수정했을 때
> >				param.put("catename", oldcate);
> >				dao.minusCateCnt(param);	// 수정 전 카테고리 개수 -1 하기
> >			}
> >			dao.updatePost(vo);		// 게시물 update
> >			postNum = vo.getIdx();	// 수정한 게시물 번호
> >			
> >		}else {						// 새로운 게시물 생성 시
> >			dao.write(vo);			// 게시물 insert
> >			postNum = dao.getPostnum(vo.getNickname());	// 작성한 게시물 번호
> >		}
> >		
> >		param.put("nickname", vo.getNickname());
> >		param.put("cate", vo.getCate());
> >		int cateCnt = dao.getCateCnt(param);	// 카테고리별 게시글 개수 가져오기
> >		param.put("catecnt", cateCnt);
> >		dao.updateCateCnt(param);	// 카테고리별 게시글 개수 update
> >		
> >		mav.setViewName("redirect:/"+nickname+"/"+postNum);	// 작성자 닉네임/작성(수정)한 게시물번호로 이동
> >		
> >		return mav;
> >	}
> >```
> 유저는 다른 유저의 게시글과 댓글을 열람할 수 있으며, 직접 댓글을 달 수 있습니다.
> > ![댓글](https://user-images.githubusercontent.com/67229566/121900043-f1f6c280-cd5f-11eb-968b-5fe186a6ffca.PNG)
> > 
> > **viewPost.jsp**
> > ```html
> > <!-- 댓글 작성 폼 -->
> ><div class="row">
> >	<textarea class="form-control" rows="5" cols="150" id="comment" placeholder="댓글을 작성하세요" wrap="hard" required></textarea><br>
> >	<button id="btnReply">댓글 작성</button>
> ></div>
> ><br>
> >
> ><!-- 댓글 리스트 -->
> ><div class="row" id="replyList">
> ><hr>
> ><c:if test="${not empty reply }">	<!-- 댓글이 있을 때 -->
> >	<c:forEach items="${reply }" var="reply">
> >			<div id="reply${reply.idx }">
> >				<div id="nickname"><a href="${cpath }/reply/${reply.nickname}"><strong><c:out value="${reply.nickname }" /></strong></a></div>
> >				<div id="reply${reply.idx }actions">
> >					<p id="reply${reply.idx }comment"><c:out value="${reply.comment }" escapeXml="false" /></p>	<!-- 화면에 그대로 나오는 태그를 제거하기 위해 escapeXml에 false값을 준다 -->
> >					<div id="reply_date"><c:out value="${reply.reply_date }"/></div>
> >					<!-- 로그인중인 유저와 댓글 작성자가 같으면 수정, 삭제 버튼 보이게 함 -->
> >					<c:if test="${login.nickname eq reply.nickname }">
> >						<div>
> >							<!-- 댓글 수정과 삭제 시 js 함수를 호출하여 처리한다 -->
> >							<span><a class="replyBtn" href="#" onclick="updateReply('${reply.idx}','${reply.comment }')" id="replyBtn${reply.idx }">수정</a></span><span> | </span>
> >							<span><a class="replyBtn" href="#" onclick="delReply('${reply.idx}')">삭제</a></span>
> >						</div>
> >					</c:if>
> >				</div>
> >			</div>
> >			<hr id="reply${reply.idx }">
> >	</c:forEach>
> ></c:if>
> ></div>
> > ```
> 댓글 조작 후 ajax를 통해 페이지를 새로고침하지 않고 변경하도록 하였습니다.<br>
> > **viewPost.js**
> > ```js
> > // 댓글 작성
> >$(btnReply).click(function(){
> >	if('${login.email}' == ''){		// 미로그인 상태에서 댓글 작성 시도 시 
> >		alert('로그인이 필요합니다!');	// 로그인 필요 알림창 띄운뒤
> >		$('#comment').val('');
> >		return;						// 댓글 작성 기능 수행 x
> >	}
> >	
> >	var comment = $('#comment').val().replace(/\n/g, "<br>");	// 줄바꿈 db에 넣기 위해 <br>로 치환한다
> >	
> >	if(comment == ''){		// 아무것도 입력하지 않은 채 작성 눌렀을 때
> >		alert('댓글을 입력해주세요!');	// 알림 표시 후 return
> >		return;
> >	}
> >	
> >	var paramData = JSON.stringify({
> >			"comment": comment,		// 댓글 내용
> >			"post_num": '${post.idx}',	// 게시글 번호
> >			"nickname": '${login.nickname}'	// 작성자 닉네임
> >	});
> >	
> >	var headers = {"Content-Type" : "application/json"
> >				, "X-HTTP-Method-Override" : "POST"};
> >	
> >	$.ajax({
> >		type:'POST',
> >		url: '${cpath}/${post.nickname}/${post.idx}/saveReply',
> >		headers: headers,
> >		data: paramData,
> >		contentType: "application/json",
> >		success: function(idx) {
> >			if(idx != 0){	// 댓글 정상적으로 insert 되면 댓글 추가 메소드 실행
> >				listReply(idx, comment);
> >				$('#comment').val('');	// 댓글 작성 폼의 값은 없애준다
> >			}
> >		},
> >		error: function(error){
> >			console.log(error);
> >		}
> >	});
> >});
> >
> > // 작성한 댓글 추가
> >function listReply(idx, comment){
> >	var date = new Date();
> >	var nowTime = date.getFullYear() + '-' + (date.getMonth()+1) + '-' + date.getDate(); // 댓글 작성 시간 구하기 yyyy-mm-dd
> >	var htmls = '';		// 추가할 영역에 댓글 형식에 맞게 만들어서 넣어준다 
> >	htmls+='<div id="reply'+idx+'"><div id="nickname">' + '${login.nickname}' + '</div><div id="reply'+idx+'actions">';
> >	htmls+='<p id="reply'+idx+'comment">' + comment + '</p>';
> >	htmls+='<div id="reply_date">' + nowTime + '</div>';
> >	htmls+='<div><span><a class="replyBtn" href="#" onclick="updateReply('+idx+',\''+comment+'\')" id="replyBtn'+idx+'">수정</a></span><span id="replyBtn"> | </span>';
> >	htmls+='<span><a class="replyBtn" href="#" onclick="delReply('+idx+')">삭제</a></span></div>';
> >	htmls+='</div></div><hr id="reply'+idx+'">';
> >	
> >	$("#replyList").append(htmls);	// 댓글 리스트 영역에 추가
> >};
> > ```
6. 소개글
> 간단하게 자신을 소개하는 글로 따로 테이블을 만들지 않고 board 테이블의 lock_post 컬럼에 'a'라는 값으로 저장되어 일반 게시글 리스트를 조회할 때 제외되도록 하였습니다. 
>![소개완](https://user-images.githubusercontent.com/67229566/121903401-39cb1900-cd63-11eb-8c4d-d06771cbe066.PNG)
>![소개글](https://user-images.githubusercontent.com/67229566/121903194-04bec680-cd63-11eb-906b-307d36c876ee.PNG)
> > 부트스트랩의 모달을 이용하여 내용을 입력 할 수 있도록 하였습니다.<br>
> > **about.jsp**
> > ```html
> >	<c:choose>
> >		<c:when test="${empty content }">	<!-- 소개글 없을 때 -->
> >			<div>
> >				<p>&nbsp;</p>
> >				<p>소개글이 아직 없습니다ㅠㅠ</p>
> >				<p>&nbsp;</p>
> >				<p>&nbsp;</p>
> >			</div>
> >			<!-- 로그인 유저와 블로그 주인이 같을 때 작성 가능 하도록 -->
> >			<c:if test="${user.nickname eq login.nickname }">
> >				<div>
> >					<button class="saveBtn btn btn-default" data-toggle="modal" data-target="#writeAbout">소개 글 작성하기</button>
> >				</div>
> >			</c:if>
> >			
> >			<!-- 소개글 작성 모달 -->
> >			<div class="modal fade" id="writeAbout" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel" aria-hidden="true">
> >				<div class="modal-dialog" role="document"> 
> >					<div class="modal-content"> 
> >						<div class="modal-header"> 
> >							<h5 class="modal-title" id="staticBackdropLabel">소개글 작성</h5> 
> >							<button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span> </button> 
> >						</div> 
> >						<form method="POST">
> >							<div class="modal-body">
> >								<input type="hidden" name="nickname" value="${login.nickname }">	 
> >								<textarea class="form-control" rows="10" cols="60" name="content" style="border: none; resize: none;" placeholder="나를 소개해주세요"></textarea>
> >							</div> 
> >							<div class="modal-footer"> 
> >								<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button> <button type="submit" class="btn btn-success">작성하기</button> 
> >							</div> 
> >						</form>
> >					</div> 
> >				</div> 
> >			</div>
> >		</c:when>
> >```
7. 유저 설정
> 프로필 이미지 설정과 닉네임을 바꿀 수 있습니다. 회원정보 수정 버튼을 클릭해야 수정 내용이 저장됩니다. 회원탈퇴는 버튼을 누르면 확인창 나타낸 후 탈퇴 기능을 실행합니다.<br>
>![유저 설정](https://user-images.githubusercontent.com/67229566/121912615-b104ab00-cd6b-11eb-99cf-7dd31d3a6d02.PNG)
> 프로필 이미지 설정<br>
> > **UserService.java**
> > ```java
> > // 프로필 수정
> >public ModelAndView settingUser(MultipartHttpServletRequest req) {
> >	ModelAndView mav = new ModelAndView("/setting"); // 수정 완료되면 다시 유저 설정페이지로 이동
> >	
> >	UserVO vo = new UserVO();
> >	vo.setEmail(req.getParameter("email")); // 유저 이메일
> >	vo.setNickname(req.getParameter("nickname")); // 유저 닉네임
> >	
> >	String imgChk = req.getParameter("imgChk");		// 파일 선택 안했을 때 no 들어옴
> >	
> >	MultipartFile mfile = req.getFile("profileimg");// 이미지 파일 데이터
> >	String imgType = mfile.getContentType();	// 이미지 파일 확장자
> >	
> >	// 이미지 파일 선택 했거나(yes) 파일 데이터가 null이 아니면
> >	if(imgChk.equals("yes") && mfile != null) {	
> >		try {
> >			// 이메일 일치하는 유저의 프로필 사진 업데이트
> >			HashMap<String, Object>param = new HashMap<String, Object>();
> >			param.put("email", vo.getEmail());
> >			param.put("img", mfile.getBytes());	// byte 데이터 map 형식으로 넣으면 blob 컬럼에 그냥 들어가진다
> >			param.put("imgtype", imgType);
> >			dao.setProfileImg(param);	// 유저 이미지 업데이트 쿼리 실행
> >		} catch (Exception e) {
> >			e.printStackTrace();
> >		}
> >	}
> >	return mav;
> >}
> > ```
> > <sub>이미지 정보를 저장하고 있는 profileimg와 imgtype</sub>
> > ![이미지 확인](https://user-images.githubusercontent.com/67229566/121923921-5fade900-cd76-11eb-80ed-fbcf80651fa0.PNG)
> >
> > 이미지 제거는 DB의 이미지값에 null로 업데이트되게 하였으며 ajax를 사용하여 페이지 이동 없이 실행 될 수 있게 하였습니다.
> > **setting.js**
> > ```js
> > // 프로필 이미지 제거
> >$('#delimg').click(function(){
> >	$.ajax({
> >		type: 'GET',
> >		url: 'delimg?email=' + '${login.email}',
> >		success: function(){
> >			// 프로젝트 내 폴더에 있는 기본 이미지 보여줌
> >			$('.img').attr('src', 'resources/img/default.jpg');
> >		}
> >	});
> >});
> > ```
> 닉네임 중복 값을 방지하기 위해 중복 체크 후 중복이 아닐 때만 닉네임을 수정할 수 있도록 버튼을 활성화/비활성화 시킵니다.
> > **setting.js**
> > ```js
> > // 닉네임 중복 확인
> >$('#nickname').blur(function() {	// 닉네임 입력창 벗어나면
> >	const nickname = $('#nickname').val();	// 입력한 닉네임 값
> >	var nnamemsg = $('#nnamemsg');
> >	var loginnickname = '${login.nickname}';	// 로그인중인 유저 닉네임
> >	
> >	if(nickname == ''){	// 아무것도 입력 안했을 때
> >		nnamemsg.text("닉네임을 입력해주세요!")
> >		$('#nnamemsgAlert').show(); // 경고 알림 나타내기
> >		$('#saveBtn').prop("disabled",false);	// 수정 버튼 비활성화
> >		return;
> >	}else if(nickname != loginnickname){	// 입력한 닉네임과 유저 닉네임이 같지 않을 때
> >		$.ajax({
> >			type: 'GET',
> >			url: 'nicknameChk?nickname=' + nickname,
> >			success: function(data) {	// 중복된 닉네임이 존재하면 select된 값 넘어옴
> >				if(data == ''){		// 넘어온 값이 없을때(중복x)
> >					$('#nnamemsgAlert').hide();				// 경고 알림창 숨김
> >					$('#saveBtn').prop("disabled",false);	// 수정 버튼 활성화
> >				}else{	// 넘어온 값이 있을 때(중복o)
> >					nnamemsg.text('이미 사용중인 닉네임입니다!');
> >					$('#nnamemsgAlert').show();				// 경고 알림창 나타냄
> >					$('#saveBtn').prop("disabled",true);	// 수정 버튼 비활성화
> >				}
> >			}
> >		})
> >	}
> >});
> > ```
8. 카테고리 설정
> 유저만의 카테고리를 추가, 삭제하고 카테고리명을 수정할 수 있습니다.
> ![카테고리](https://user-images.githubusercontent.com/67229566/121924567-fd091d00-cd76-11eb-896b-6fa2517ff043.PNG)
9. Interceptor
> 비회원인 경우 게시글 조회 외의 기능은 사용할 수 없습니다. 부적절한 url으로 인한 허가되지 않은 페이지 접근을 막습니다.
> > **UserInterseptor.java**
> > ```java
> > // preHandle() 컨트롤러보다 먼저 수행된다
> >@Override
> >public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
> >        throws Exception {
> >	
> >	HttpSession session = request.getSession();		// session 객체 가져옴
> >	Object obj = session.getAttribute("login");		// 사용자 정보 담고 있는 객체 가져옴
> >	
> >	if(obj == null) {		// 로그인 된 세션 없는 경우
> >		response.sendRedirect("/login");	// 로그인 페이지로 이동
> >		return false;	// 컨트롤러 요청으로 가지 않도록 false 반환
> >	}
> >	// 요청받은 페이지로 이동
> >	return true;
> >}
> > ```
> 로그인중인 유저가 로그인 페이지나 회원가입 페이지로 이동하는 행위를 막습니다.
> > **AfterLoginInterceptor.java**
> > ```java
> > @Override
> >public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
> >		throws Exception {
> >	// 로그인 후 로그인 페이지 or 회원가입 페이지 이동 할 경우
> >	HttpSession session = request.getSession();
> >	if(session.getAttribute("login") != null) {	// 로그인 세션 있을 경우
> >		response.sendRedirect("/home");	// 메인 페이지로 이동
> >		return false;
> >	}
> >	return true;	// 없으면 요청한 페이지로 이동
> >}
### 클라우드 서비스 (aws)<br>
 클라우드 서비스에 데이터베이스와 서버를 올려놓으면 나의 로컬 컴퓨터에서 뿐만 아니라 어디에서든 프로젝트 조작이 가능하다는 장점이 있어 aws를 사용하게 되었습니다.
 1. RDS
 > 데이터베이스는 MySQL 프리티어를 사용하였습니다.
 >![rds](https://user-images.githubusercontent.com/67229566/121930625-8cb1ca00-cd7d-11eb-9ab3-1cdebd87d4f4.PNG)
 2. EC2
 > 완성된 프로젝트는 EC2를 사용하여 배포하였으며, 탄력적 ip를 할당받아 고정 ip를 사용합니다.<br>
 > 인스턴스 생성 시 사용된 OS는 Ubuntu입니다.
 > ![ec2](https://user-images.githubusercontent.com/67229566/121930984-ff22aa00-cd7d-11eb-9fcb-81c4523e733b.PNG)
## 개선사항
 * mail api를 이용해 사용자 이메일에 임시비밀번호를 발송해주고 이것을 이용해 다시 비밀번호를 설정할 수 있게 하는 비밀번호 찾기 기능
 * 사용자가 원하는 게시글을 찾아 열람할 수 있게 검색 기능
 * 게시글 작성 시 이미지 파일을 추가하는 기능
 * 메인 페이지 일반 페이징이 아닌 무한 스크롤 페이징 적용
## 느낀점
한달안에 완성시키자 라는 생각으로 프로젝트를 시작했지만 혼자서 진행하다 보니 새로운 기술을 적용 시키거나 에러 메시지가 나올 때면 해결하기 위해 검색하느라 생각보다 시간이 많이 들었고, 한달이란 시간은 촉박했습니다. 잘 작동된다고 확인하고 넘어갔던 기능들이 테스트 과정에서 전혀 다른 결과나 에러가 나올때면 지치고 그만두고 싶기도 했지만 제가 몰랐던 새로운 기술들을 알게 되고 문제를 해결할 때면 뿌듯함과 해냈다는 성취감에 아직 완벽하진 않지만 프로젝트를 완성 시킬 수 있었습니다.
 
 이 프로젝트를 진행 하면서 배운것도 정말 많고 아쉬운점도 많습니다. 시간이 부족해 구현하지 못한 기능들은 계속 수정을 거치며 추가할 예정이며 새로운 것에 도전해 보는 프로젝트도 계획중에 있습니다. 














