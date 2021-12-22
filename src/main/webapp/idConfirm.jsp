<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>아이디 중복 확인</title>
</head>
<body>
	<h1 align="center" style="font-family:Segoe Script;font-size:40px">Id Check</h1>
	<!-- 정보 받아서 IdCheck로 넘기기!! -->
	<form name="frmIdCheck" action="IdCheck.jsp" method="post">
		<table border="8" bordercolor="#E6E6FA" style="margin-left:auto; margin-right:auto;">
			<tr>
				<th>
				<input type="text" name="check_id" placeholder="확인할 아이디" maxlength="20" size="50">
				<input type="submit" value="중복 확인">
				</th>
			</tr>
		</table>
	</form>
</body>
</html>