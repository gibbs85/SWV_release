<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그아웃</title>
</head>
<body>
	<%
	session.removeAttribute("id");
	session.removeAttribute("user_type");
	out.println("<script>");
	out.println("alert('로그아웃 되었습니다!')");
	out.println("location.href='Main.jsp'");
	out.println("</script>");
	%>
</body>
</html>