<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="dongok.Query" %>
<%@ page import="dongok.Post" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="dongok.css">
<meta charset="EUC-KR">
<title>ȸ������</title>
<style>
#container{
text-align:center;
}
</style>
</head>
<body>
	<% // �̹� �α����� �� ���¿��� ȸ�������� ���� ���(�̺κ��� ��ư�� ���������� �ϴ���..?)
		if(session.getAttribute("id")!=null){
			out.println("<script>");
			out.println("alert('ȸ�������� �̹� �Ǿ��ֽ��ϴ�!')");
			out.println("location.href='Main.jsp'");
			out.println("</script>");
			
		}
	%>
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
<!-------------------------------------------------------------------------------------------------------------->	
	
	<div id="container">
		<table class="post_list_nounderline_nodark">
		<td>
		<h1 style="font-family:Segoe Script;"> Join Membership </h1>
		<form name="memership" action="JoinCheck.jsp" method="post">
			<table border="8" bordercolor="#E6E6FA" style="margin-left:auto; margin-right:auto;">
				<!-- ���̵� -->
				<tr>
					<th>���̵�</th>
					<th align="left">
						<input type="text" name="new_id" placeholder="���̵�" maxlength="20" size="50">
						(20�� ����)
						<!-- �ߺ� �˻� ��ư - > �ߺ�Ȯ�� ������ ��� -->
						<input type="button" value="���̵� �ߺ� Ȯ��" onclick="window.open('IdConfirm.jsp')" id="button_comment" style="width: 130px; height: 30px; padding:4px;">
					</th>
				</tr>
				
				<!-- ��й�ȣ -->
				<tr>
					<th>��й�ȣ</th>
					<th align="left">
						<input type="password" name="new_pw" placeholder="��й�ȣ" maxlength="20" size="50" >
						(20�� ����)
					</th>
				</tr>
				<!-- ��й�ȣ Ȯ�� -->
				<tr>
					<th>��й�ȣ Ȯ��</th>
					<th align="left">
						<input type="password" name="chk_pw" placeholder="�����ȣ Ȯ��" maxlength="20" size="50" >
					</th>
				</tr>
				
				<!-- �̸� -->
				<tr>
					<th>�̸�</th>
					<th align="left">
						<input type = "text" name="new_name" placeholder="�̸�" maxlength="10" size="50">
					</th>
				</tr>
				
				<!-- �̸��� -->
				<tr>
					<th>�̸���</th>
					<th align="left">
						<input type = "text" name="new_email" placeholder="�̸���" maxlength="50" size="50">
					</th>
				</tr>
				
				<!-- ���� type -->
				<tr>
					<th> Ȱ���� ���� </th>
					<th align="left">
						<select name="new_userType">
							<option value="1" selected="selected">Ʃ��</option>
							<option value="2">ƩƼ</option>
						</select>
					</th>
				</tr>
			</table>
			<br>
			
			<!-- button -->
			<input type="submit" value="�����ϱ�" id="button_comment" style="width: 90px; padding:4px;">
		</form>
		</td>
		</table>
	</div>

</body>
</html>