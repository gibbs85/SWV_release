<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dongok.Query" %>
<%@ page import="dongok.Post" %>
<%@ page import="dongok.Comment" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="dongok.css">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String writer_id = (String)request.getParameter("id");
		String comment_content = (String)request.getParameter("comment");
		int post_id = Integer.parseInt(request.getParameter("post_id"));
		
		Comment comment = new Comment(post_id, comment_content, writer_id);
		
	%>
	
	<form name = "modcomplete" method="post" action="post_view.jsp">
		<input type="hidden" name="post_id" value="<%=post_id%>">
	</form>
	
	<%
		Query sql = new Query();
		sql.insert_value(comment);
		

		out.println("<script>");
		out.println("document.modcomplete.submit()");
		out.println("</script>");
	%>
	
	
</body>
</html>