<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
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
	
	<div id="container">
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
						<input type="button" value="���̵� �ߺ� Ȯ��" onclick="window.open('IdConfirm.jsp')">
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
			<input type="submit" value="�����ϱ�">
		</form>
	</div>

</body>
</html>