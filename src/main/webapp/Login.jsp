<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α��� ������</title>
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
	//���� Ȯ�� -> �α����� �̹� �Ǿ����� ��
	if(session.getAttribute("id")!= null){
		out.println("<script>");
		out.println("alert('�̹� �α����� �Ǿ� �ֽ��ϴ�!')");
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
								<input type="text" name = "input_id" placeholder = "���̵�" maxlength = "20" size = 50>
							</label>
						</th>
					</tr>
					<!-- pw -->
					<tr>
						<th>
							<label style = "display : block;">
								<input type = "password" name = "input_pw" placeholder = "��й�ȣ" maxlength = "20" size = 50>
							</label>
						</th>
					</tr>
				</table>
				
				<br>
				<!-- button -->
				<input type = "submit" value = "�α���">
				<!-- ȸ���������� �̾����� ��ư -->
				<button type="button" onclick="location.href='UserJoin.jsp' ">ȸ������</button>
			</form>			
		</div>
	<% } %>
</body>
</html> 