<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		//DB���� 
		String jdbcDriver = "jdbc:mariadb://localhost:3306/dbswvideo";
		String dbUser = "root";
		String dbPass = "2015211131";
	
		Connection conn = null;
		PreparedStatement preStmt = null;
		String query = "select * from user where id = ?";
		
		try{
			String driver="org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			preStmt = conn.prepareStatement(query);
			
			//���̵� �ߺ� â���� ���� ������  
			request.setCharacterEncoding("UTF-8"); //���ڱ��� ����
			String user_id = request.getParameter("check_id");
			
			//���� ó��
			preStmt.setString(1, user_id); // ù��° ?=user_id
			ResultSet rs = preStmt.executeQuery();
			
			if(rs.next()){ // ������ id�� ���� ����� ���� ���
				out.println("<script>");
				out.println("alert('�̹� �����ϴ� ���̵��Դϴ�! �ٽ� �õ����ּ���.')");
				out.println("location.href='IdConfirm.jsp'"); // ���̵� Ȯ��â���� �̵�
				out.println("</script>");
			}
			
			else{ // ������ id�� ���� ����� ���� ���
				out.println("<script>");
				out.println("alert('��� ������ ���̵��Դϴ�!')");
				out.println("window.close()"); // ���̵� Ȯ�� â ���� -> ȸ������ â���� ���ư���
				out.println("</script>");
			}
					
		}catch(Exception e){ 
			e.printStackTrace();
		} finally{
			try{
				preStmt.close();
				conn.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
	%>

</body>
</html>