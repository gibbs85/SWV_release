<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="dongok.Query" %>
<%@ page import="dongok.Post" %>
<%@ page import="dongok.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="dongok.css">
<title>추천 영상 조회</title>
</head>
<body>
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
	
<!-------------------------------------------------------추천 영상 목록------------------------------------------------------->
	<%
		//session에서 튜티 정보 받아오기
		String tutie_id = (String)session.getAttribute("id");
		Query sql = new Query();
		ResultSet user = sql.search_user_byID(tutie_id);
		user.next();
		String user_id = user.getNString("id");
		String name = user.getNString("name");
		String email = user.getNString("email");
		String message = user.getNString("message");
		User tutie = new User(user_id, "NONE", name, email, 1, message);
		
		ResultSet liked_post_ids = sql.search_liked_posts_id(tutie);//추천 누른 게시글ID resultset
		
		
	%>	
	<div id="div_post_list">
		<table class="post_list">
			<caption id="caption_title">추천을 누른 게시물</caption>
			<tr>
				<th scope="col" width="10%">게시물ID</th>
				<th scope="col" width="60%">제목</th>
				<th scope="col" width="15%">작성자</th>
				<th scope="col" width="15%">작성일</th>
			</tr>
			<%
				while (liked_post_ids.next()){
					
					Post post = sql.search_post_byID(liked_post_ids.getInt("upvoted_post_id"));
					
					int id = post.post_id;
					String title = post.post_title;
					String date = post.post_date;
					String writer_id = post.writer_id;

					ResultSet writer = sql.search_user_byID(writer_id);
					writer.next();
					String writer_name = writer.getNString("name");
			%>
			<tr>
				<td align="center"> <%=id %></td>
				<td>
					<form action = "TEMP_Post.jsp" accept-charset="utf-8" method="get">
					<input type="hidden" name="post_id" value = <%=id%>>
					<button type="submit" class="none_button_text" name="post_title"><%=title%></button>
					</form>
				</td>
				<td align="center">
					<form action = "TutorUploaded.jsp" accept-charset="utf-8" method="get">
					<input type="hidden" name="tutor_id" value = <%=writer_id%>>
					<button type="submit" class="none_button_text" name="tutor_id"><%=writer_name%></button>
					</form>
				</td>
				<td align="center"> <%=date %></td>
				<%
					}
				%>
			</tr>
		</table>
	</div>
</body>
</html>