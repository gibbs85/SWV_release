<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
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
	
	<div id="container">
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
						<input type="button" value="아이디 중복 확인" onclick="window.open('IdConfirm.jsp')">
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
			<input type="submit" value="가입하기">
		</form>
	</div>

</body>
</html>