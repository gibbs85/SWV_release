<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="dongok.Query" %>
<%@ page import="dongok.Post" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="dongok.css">
<meta charset="EUC-KR">
<title>회원가입</title>
<style>
#container{
text-align:center;
}
</style>
</head>
<body>
	<% // 이미 로그인이 된 상태에서 회원가입을 누를 경우(이부분은 버튼을 없어지도록 하던지..?)
		if(session.getAttribute("id")!=null){
			out.println("<script>");
			out.println("alert('회원가입이 이미 되어있습니다!')");
			out.println("location.href='Main.jsp'");
			out.println("</script>");
			
		}
	%>
	<!-------------------------------------------------------네비게이션------------------------------------------------------->

<!--  css필요함. head에 <link rel="stylesheet" href="dongok.css"> -->
	<div id="div_nav_container">
		<div id="div_nav_button">
		
	<!-- 로그인되지 않았을 때 -->
	<% if(session.getAttribute("id") == null) { %>
			<button type="button" class="nav_none_buttonlike" style="float: left;" onclick="location.href='Main.jsp' ">홈 아이콘</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;"  onclick="location.href='UserJoin.jsp' ">회원가입</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;" onclick="location.href='Login.jsp' ">로그인</button>
			
	<% } else{//로그인 되어있다면 session에서 받은 id로 User 서치
		Query sql = new Query();
		ResultSet user = sql.search_user_byID((String)session.getAttribute("id"));
		user.next();
		String user_name = user.getNString("name");//이름만 받아옴
	
	%>
	<!-- 유저타입 == 0. admin -->
		<%	if((Integer)session.getAttribute("user_type") == 0) {%>
			<button type="button" class="nav_none_buttonlike" style="float: left;" onclick="location.href='Main.jsp' ">홈 아이콘</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;" >회원관리</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;"  onclick="location.href='LogOut.jsp' ">로그아웃</button>
			
	<!-- 유저타입 == 1. 튜터 -->
		<% } else if((Integer)session.getAttribute("user_type") == 1){ %>
			<button type="button" class="nav_none_buttonlike" style="float: left;" onclick="location.href='Main.jsp' ">홈 아이콘</button>
			<form action = "TutorUploaded.jsp" accept-charset="utf-8" method="get">
				<input type="hidden" name="tutor_id" value = <%=session.getAttribute("id") %>>
				<button type="submit" class="nav_none_buttonlike" style="float: right;">영상관리</button>
			</form>
			<button type="button" class="nav_none_buttonlike" style="float: right;" onClick = "location.href='post_new.jsp'">글쓰기</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;"   onclick="location.href='LogOut.jsp' ">로그아웃</button>
			
	<!-- 유저타입 == 2. 튜티 -->
		<% } else if((Integer)session.getAttribute("user_type") == 2){%>
			<button type="button" class="nav_none_buttonlike" style="float: left;" onclick="location.href='Main.jsp' ">홈 아이콘</button>
			<button type="button" class="nav_none_buttonlike" style="float: right; width:100px;" onclick="location.href='LikedPosts.jsp' ">추천영상조회</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;"   onclick="location.href='LogOut.jsp' ">로그아웃</button>
		<% } %>
			<form action = "TEMP_Profile.jsp" accept-charset="utf-8" method="get">
				<input type="hidden" name="user_id" value = <%=session.getAttribute("id") %>>
	        	<button type="submit" class="nav_none_buttonlike" style="float: right;"><b><%=user_name%></b> 님, 환영합니다. </button>
	        </form>
	<%} %>
		</div>
		<br>
		<br>
		<br>
		<br>
		<div style="clear:both;">
			<form id="form_searchbox">
				<input type="text" id="textfield_search_main" placeholder="검색어를 입력하세요." style="float: center;">
				<input type="submit" id="button_search" name="button_search" value="검색" style="float: center;">
			</form>
		</div>
	</div>
<!-------------------------------------------------------------------------------------------------------------->	
	
	<div id="container">
		<table class="post_list_nounderline_nodark">
		<td>
		<h1 style="font-family:Segoe Script;"> Join Membership </h1>
		<form name="memership" action="JoinCheck.jsp" method="post">
			<table border="8" bordercolor="#E6E6FA" style="margin-left:auto; margin-right:auto;">
				<!-- 아이디 -->
				<tr>
					<th>아이디</th>
					<th align="left">
						<input type="text" name="new_id" placeholder="아이디" maxlength="20" size="50">
						(20자 내외)
						<!-- 중복 검사 버튼 - > 중복확인 페이지 띄움 -->
						<input type="button" value="아이디 중복 확인" onclick="window.open('IdConfirm.jsp')" id="button_comment" style="width: 130px; height: 30px; padding:4px;">
					</th>
				</tr>
				
				<!-- 비밀번호 -->
				<tr>
					<th>비밀번호</th>
					<th align="left">
						<input type="password" name="new_pw" placeholder="비밀번호" maxlength="20" size="50" >
						(20자 내외)
					</th>
				</tr>
				<!-- 비밀번호 확인 -->
				<tr>
					<th>비밀번호 확인</th>
					<th align="left">
						<input type="password" name="chk_pw" placeholder="비빌번호 확인" maxlength="20" size="50" >
					</th>
				</tr>
				
				<!-- 이름 -->
				<tr>
					<th>이름</th>
					<th align="left">
						<input type = "text" name="new_name" placeholder="이름" maxlength="10" size="50">
					</th>
				</tr>
				
				<!-- 이메일 -->
				<tr>
					<th>이메일</th>
					<th align="left">
						<input type = "text" name="new_email" placeholder="이메일" maxlength="50" size="50">
					</th>
				</tr>
				
				<!-- 유저 type -->
				<tr>
					<th> 활동할 역할 </th>
					<th align="left">
						<select name="new_userType">
							<option value="1" selected="selected">튜터</option>
							<option value="2">튜티</option>
						</select>
					</th>
				</tr>
			</table>
			<br>
			
			<!-- button -->
			<input type="submit" value="가입하기" id="button_comment" style="width: 90px; padding:4px;">
		</form>
		</td>
		</table>
	</div>

</body>
</html>