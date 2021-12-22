<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="refresh" content="3;url=post_view.jsp">

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	try {
		String dir_video = request.getParameter("fileName");
		String post_title = request.getParameter("subject");
		String post_content = request.getParameter("content");
		String post_date = null;
		String writer_id = request.getParameter("id");
		String dbName = "dbswvideo";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/" + dbName;
		String dbUser = "root";
		String dbPass = "2015211131";
		
		Connection conn = null;
		Statement stmt = null;
		
		String insert_value_single = "INSERT INTO post(dir_video, post_title, post_content, post_date, writer_id) VALUES ('" + dir_video + "','" + post_title + "','" + post_content + "','" + post_date + "','" + writer_id + "');";
		String driver = "org.mariadb.jdbc.Driver";
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		stmt.executeUpdate(insert_value_single);	
		%>
		
		
		<div>
		<h1>결과</h1>
		<p>전송된 내용은 다음과 같습니다.</p>
		<p><%=dir_video %></p>
		<p><%=post_title %></p>
		<p><%=post_content %></p>
		<p><%=post_date %></p>
		<p><%=writer_id %></p>
	</div>
<%
	} catch (NumberFormatException e) {%>
	<p>error</p> <%}%>
	
</body>
</html>