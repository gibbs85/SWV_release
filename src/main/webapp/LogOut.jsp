<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α׾ƿ�</title>
</head>
<body>
	<%
	session.removeAttribute("id");
	session.removeAttribute("user_type");
	out.println("<script>");
	out.println("alert('�α׾ƿ� �Ǿ����ϴ�!')");
	out.println("location.href='Main.jsp'");
	out.println("</script>");
	%>
</body>
</html>