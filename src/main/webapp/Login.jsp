<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="dongok.Query" %>
<%@ page import="dongok.Post" %>
<%@ page import="dongok.User" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="dongok.css">
<meta charset="EUC-KR">
<title>로그인 페이지</title>
<style>
#header{
text-align:center;
}
#container{
text-align:center;
}
table{
width:350px;
}
</style>
</head>
<body>


	<!-- login session confirm -->
	<%
	//세션 확인 -> 로그인이 이미 되어있을 때
	if(session.getAttribute("id")!= null){
		out.println("<script>");
		out.println("alert('이미 로그인이 되어 있습니다!')");
		out.println("location.href='Main.jsp'");
		out.println("</script>");
	}
	else{ %>
		<!-- navigation bar -->
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
	
		<!-- id / pw -->
		<div id="container" style="border:5px #FFFACD">
		<table class="post_list_nounderline_nodark">
		<td>
			<h1 style="font-family:Segoe Script;"> Log In </h1>
			<form name = "frmIDLogin" action = "LoginCheck.jsp" method="post">
				<table border="8" bordercolor="#E6E6FA" style="margin-left:auto; margin-right:auto;">
					<!-- id -->
					<tr>
						<th>
							<label style="display : block;">
								<input type="text" name = "input_id" placeholder = "아이디" maxlength = "20" size = 50>
							</label>
						</th>
					</tr>
					<!-- pw -->
					<tr>
						<th>
							<label style = "display : block;">
								<input type = "password" name = "input_pw" placeholder = "비밀번호" maxlength = "20" size = 50>
							</label>
						</th>
					</tr>
				</table>
				
				<br>
				<!-- button -->
				<input type = "submit" value = "로그인" id="button_comment" style="width: 70px; padding:4px;">
				<!-- 회원가입으로 이어지는 버튼 -->
				<button type="button" onclick="location.href='UserJoin.jsp' " id="button_comment" style="width: 80px; padding:4px;" >회원가입</button>
			</form>
		</td>
		</table>			
		</div>
	<% } %>
</body>
</html> 