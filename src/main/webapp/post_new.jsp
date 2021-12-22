<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="dongok.css">
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
<!-------------------------------------------------------네비게이션------------------------------------------------------->

<!--  css필요함. head에 <link rel="stylesheet" href="dongok.css"> -->
	<div id="div_nav_container">
		<div id="div_nav_button">
		
	<!-- 로그인되지 않았을 때 -->
	<% 	if(session.getAttribute("id") == null) { %>
			<button type="button" class="nav_none_buttonlike" style="float: left;" onclick="location.href='Main.jsp' ">홈 아이콘</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;"  onclick="location.href='UserJoin.jsp' ">회원가입</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;" onclick="location.href='Login.jsp' ">로그인</button>
			
	<!-- 유저타입 == 0. admin -->
	<%	} else if((Integer)session.getAttribute("user_type") == 0) {%>
			<button type="button" class="nav_none_buttonlike" style="float: left;" onclick="location.href='Main.jsp' ">홈 아이콘</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;" >회원관리</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;"  onclick="location.href='LogOut.jsp' ">로그아웃</button>
			
	<!-- 유저타입 == 1. 튜터 -->
	<% } else if((Integer)session.getAttribute("user_type") == 1){ %>
			<button type="button" class="nav_none_buttonlike" style="float: left;" onclick="location.href='Main.jsp' ">홈 아이콘</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;" onclick="location.href='TutorUploaded.jsp' ">영상관리</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;" onClick = "location.href='post_new.jsp'">글쓰기</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;"   onclick="location.href='LogOut.jsp' ">로그아웃</button>
			
	<!-- 유저타입 == 2. 튜티 -->
	<% } else if((Integer)session.getAttribute("user_type") == 2){%>
			<button type="button" class="nav_none_buttonlike" style="float: left;" onclick="location.href='Main.jsp' ">홈 아이콘</button>
			<button type="button" class="nav_none_buttonlike" style="float: right; width:100px;" onclick="location.href='Referred.jsp' ">추천영상조회</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;"   onclick="location.href='LogOut.jsp' ">로그아웃</button>
	<% } 
	String user_id = (String) session.getAttribute("id"); 
	%>
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
<!-------------------------------------------------------게시물 작성------------------------------------------------------->
<% 	Date from = new Date();
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String to = transFormat.format(from);
	%>
    <div id="div_post_list">
	    <form action="post_check.jsp" method="post" enctype="Multipart/form-data">
		    <input type="hidden" name="id" value="<%=user_id %>" readonly><br/>
		    <input type="hidden" name="date" value="<%=to %>"readonly> <br/>
    		<table class="post_list_nounderline">
		        <td>제목 : <input style="width:80%;" type="text" name="subject" /><td>
		    </table>
		    <br>
		    <table class="post_list_nounderline">
		        <td>본문 :<br> <textarea style="width:95%; height:400px; margin-top: 5px;" type ="memo" cols="50" rows="8" name = "content"></textarea> </td> 
		        <!--
			           파일 업로드는 input type="file"로 지정한다.
		    	    -->
		    </table>
		    <table class="post_list_nounderline">
		        <td>
			       	파일명 : <input type="file" name="fileName" /><br/>
			    </td>
	    	</table>
	    	<br>
	    		<input style="margin-left: auto; margin-right: auto; display:block;" type="submit" id="button_comment" value="전송" />
			    <input style="margin-left: auto; margin-right: auto; display:block;" type="reset" id="button_comment" value="취소" />
	    </form>
    </div>

</body>
</html>