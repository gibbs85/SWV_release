<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
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
		
		<!-- id / pw -->
		<div id="container" style="border:5px #FFFACD">
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
				<input type = "submit" value = "로그인">
				<!-- 회원가입으로 이어지는 버튼 -->
				<button type="button" onclick="location.href='UserJoin.jsp' ">회원가입</button>
			</form>			
		</div>
	<% } %>
</body>
</html> 