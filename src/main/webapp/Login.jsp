<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="dongok.Query" %>
<%@ page import="dongok.Post" %>
<%@ page import="dongok.User" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="dongok.css">
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
		<!-------------------------------------------------------�׺���̼�------------------------------------------------------->

<!--  css�ʿ���. head�� <link rel="stylesheet" href="dongok.css"> -->
	<div id="div_nav_container">
		<div id="div_nav_button">
		
	<!-- �α��ε��� �ʾ��� �� -->
	<% if(session.getAttribute("id") == null) { %>
			<button type="button" class="nav_none_buttonlike" style="float: left;" onclick="location.href='Main.jsp' ">Ȩ ������</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;"  onclick="location.href='UserJoin.jsp' ">ȸ������</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;" onclick="location.href='Login.jsp' ">�α���</button>
			
	<% } else{//�α��� �Ǿ��ִٸ� session���� ���� id�� User ��ġ
		Query sql = new Query();
		ResultSet user = sql.search_user_byID((String)session.getAttribute("id"));
		user.next();
		String user_name = user.getNString("name");//�̸��� �޾ƿ�
	
	%>
	<!-- ����Ÿ�� == 0. admin -->
		<%	if((Integer)session.getAttribute("user_type") == 0) {%>
			<button type="button" class="nav_none_buttonlike" style="float: left;" onclick="location.href='Main.jsp' ">Ȩ ������</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;" >ȸ������</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;"  onclick="location.href='LogOut.jsp' ">�α׾ƿ�</button>
			
	<!-- ����Ÿ�� == 1. Ʃ�� -->
		<% } else if((Integer)session.getAttribute("user_type") == 1){ %>
			<button type="button" class="nav_none_buttonlike" style="float: left;" onclick="location.href='Main.jsp' ">Ȩ ������</button>
			<form action = "TutorUploaded.jsp" accept-charset="utf-8" method="get">
				<input type="hidden" name="tutor_id" value = <%=session.getAttribute("id") %>>
				<button type="submit" class="nav_none_buttonlike" style="float: right;">�������</button>
			</form>
			<button type="button" class="nav_none_buttonlike" style="float: right;" onClick = "location.href='post_new.jsp'">�۾���</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;"   onclick="location.href='LogOut.jsp' ">�α׾ƿ�</button>
			
	<!-- ����Ÿ�� == 2. ƩƼ -->
		<% } else if((Integer)session.getAttribute("user_type") == 2){%>
			<button type="button" class="nav_none_buttonlike" style="float: left;" onclick="location.href='Main.jsp' ">Ȩ ������</button>
			<button type="button" class="nav_none_buttonlike" style="float: right; width:100px;" onclick="location.href='LikedPosts.jsp' ">��õ������ȸ</button>
			<button type="button" class="nav_none_buttonlike" style="float: right;"   onclick="location.href='LogOut.jsp' ">�α׾ƿ�</button>
		<% } %>
			<form action = "TEMP_Profile.jsp" accept-charset="utf-8" method="get">
				<input type="hidden" name="user_id" value = <%=session.getAttribute("id") %>>
	        	<button type="submit" class="nav_none_buttonlike" style="float: right;"><b><%=user_name%></b> ��, ȯ���մϴ�. </button>
	        </form>
	<%} %>
		</div>
		<br>
		<br>
		<br>
		<br>
		<div style="clear:both;">
			<form id="form_searchbox">
				<input type="text" id="textfield_search_main" placeholder="�˻�� �Է��ϼ���." style="float: center;">
				<input type="submit" id="button_search" name="button_search" value="�˻�" style="float: center;">
			</form>
		</div>
	</div>
	
		<!-- id / pw -->
		<div id="container" style="border:5px #FFFACD">
		<table class="post_list_nounderline_nodark">
		<td>
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
				<input type = "submit" value = "�α���" id="button_comment" style="width: 70px; padding:4px;">
				<!-- ȸ���������� �̾����� ��ư -->
				<button type="button" onclick="location.href='UserJoin.jsp' " id="button_comment" style="width: 80px; padding:4px;" >ȸ������</button>
			</form>
		</td>
		</table>			
		</div>
	<% } %>
</body>
</html> 