# JMLog
> http://15.165.184.233:8080/<br>
> *서버 중지 상태 시 사이트 접속이 안 될 수 있습니다.*
------------
## 프로젝트 계획
> 웹 프로그래밍의 기본적인 CRUD 기능을 공부하기위해 이번 프로젝트를 계획하였습니다. CRUD 기능을 가장 잘 사용할 수 있는 블로그라는 주제를 선택하였고, 제가 자주 들어가는 사이트인 [velog](https://velog.io/)와 티스토리 블로그를 참고하였습니다. 계획을 하면서 단순한 나만의 블로그 관리에서 유저간의 교류가 가능한 블로그 플랫폼으로 만들기위해 자연스럽게 기능들을 추가하게 되었고 처음으로 혼자 계획하고 완성한 프로젝트가 되었습니다.
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
 ![JMLog Diagram](https://user-images.githubusercontent.com/67229566/121813092-8819e280-cca5-11eb-946f-aa05908adfe4.PNG)<br>
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
> *비밀번호 찾기는 구현 예정입니다ㅠㅠ*
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
4.게시글
>
>
~~내용 수정중입니다ㅠㅠ~~
















