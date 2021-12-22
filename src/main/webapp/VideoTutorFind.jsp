<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� �� Ʃ�� �˻�â</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#tutor_div").hide();
	$("$video_div").hide();
});
function div_show(){
	//document.getElementById("tutor_div").style.display="block";
	//document.getElementById("video_div").style.display="block";
	
	$("#tutor_div").show();
	$("#video_div").show();
}
</script>
<style>
#header{
text-align:center;
}
#container{
text-align:center;
}
</style>
</head>
<body>
	<div id="container">
	<h1 style="font-family:Segoe Script;">Search</h1>
	<form>
		<table border="8" bordercolor="#E6E6FA" style="margin-left:auto; margin-right:auto;">
			<tr>
				<td colspan="2"><span style="font-family:Segoe Script;">Search</span></td>
			</tr>
			<!-- �˻�â -->
			<tr>
				<td>
					<input type="text" name="input_searchThing" placeholder="�˻��� Ʃ�� �Ǵ� ����" maxlength="50" size="50">
					<input type="submit" value="�˻��ϱ�">
				</td>
			</tr>
		</table>
	</form>
	
	

	<%
			//DB����
			String jdbcDriver="jdbc:mariadb://localhost:3307/dbswvideo";
			String dbUser="root";
			String dbPass="cjy23086";
			
			Connection conn = null;
			PreparedStatement preStmt = null;
			PreparedStatement preStmt2 = null;
			
			// �˻�â�� �Էµ� �� ��������
			request.setCharacterEncoding("euc-kr");
			String rKey = request.getParameter("input_searchThing");
			String search_key = "%" + rKey + "%"; // �ش� ���ڰ� �� ��ġ ��� ���� �˻�
			
			// ���� : user ���̺��� Ʃ��(type=1) �̸鼭 ����� �̸� x
			String search_tutor = "select * from user where user_type = 1 and name like ?";
			
			// ���� : post ���̺��� �����̸� 
			String search_video = "select * from post where post_title like ?";
			
			try{
				String driver="org.mariadb.jdbc.Driver";
				Class.forName(driver);
				conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
				
				preStmt = conn.prepareStatement(search_tutor);
				%>
				
				<!-- �˻��� ���� ��� â �� Ʃ��, �з� -->
				<table border="8" bordercolor="#E6E6FA" style="margin-left:auto; margin-right:auto;">
					<tr align="center">
						<td>Ʃ�� �̸�</td>
						<td>Ʃ�� ���̵�</td>
					</tr>
				<% 
					// �˻� ��� ���� ������ ����
					preStmt.setString(1, search_key);
					
					//���� ����
					ResultSet rs = preStmt.executeQuery();
					
					if(rs.next()){
						do{
						String tutor_name = rs.getString("name");
						String tutor_id = rs.getString("id");
				%>
				
				<!-- �˻��� ���� ���â �� Ʃ��, ����� -->
				<tr align="center">
					<td>
						<a href="SearchInfo.jsp?tutor_id=<%=tutor_id %>">
							<%=tutor_name %>
						</a>
					</td>
					<td><%=tutor_id %></td>
				</tr>
				
			<% 
						}while(rs.next());
			%>
			
			
			<%
					}else{ // Ʃ�Ϳ� ���� ����� ���� ���
			%>
			<tr align="center">
				<td colspan="2">
					<h1>Ʃ�Ϳ� ���� ��� ����</h1>
				</td>
			</tr>
				
			<%
				} //else
			%>
			</table> 
			<hr width="50%"> <!-- Ʃ�Ϳ� ���� �˻���� �� & ���μ�-->
			
			
			<%
				preStmt2 = conn.prepareStatement(search_video);
			%>
			
			<!-- �˻��� ���� ��� â �� ����, �з� -->
				<table border="8" bordercolor="#E6E6FA" style="margin-left:auto; margin-right:auto;">
					<tr align="center">
						<td>���� ����</td>
						<td>���� �� ����</td>
					</tr>
					
			<%
				// ������ �˻���� ���� �Ѱ���
				preStmt2.setString(1, search_key);
			
				// ���� ����
				ResultSet rs2 = preStmt2.executeQuery();
				
				if(rs2.next()){
					do{
						String video_title = rs2.getString("post_title");
						String video_content = rs2.getString("post_content");
						String video_postid = rs2.getString("post_id");
			%>
				<!-- �˻��� ���� ���â �� ����, ����� -->
				<tr align="center">
					<td>
						<a href="SearchInfo.jsp?video_postid=<%=video_postid %>">
							<%=video_title %>
						</a>
					</td>
					<td><%=video_content %></td>
				</tr>
				
			<% 
					}while(rs2.next());
				}else{ // ���� ���� �˻� ����� ���� �� 
			%>
			<tr align="center">
				<td colspan="2">
					<h1>���� ���� ��� ����</h1>
				</td>
			</tr>
			
			<% 
				} // else
			
			}catch(Exception e){ 
				e.printStackTrace();
			}finally{
				try{
					preStmt.close();
					conn.close();
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
			%>
	</table>
	
</html>