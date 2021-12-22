<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α��� ���� Ȯ��</title>
</head>
<body>
	<%
		//DB ����
		String jdbcDriver="jdbc:mariadb://localhost:3306/dbswvideo";
		String dbUser="root";
		String dbPass="2015211131";
		
		Connection conn = null;
		PreparedStatement preStmt = null;
		
		try{
			String driver="org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			//login ���������� ���� ������
			request.setCharacterEncoding("UTF-8"); //���ڱ��� ����
			String id = request.getParameter("input_id");
			String pw = request.getParameter("input_pw");
			
			//ó���� ����
			String query = "select * from user where id = ?";
			preStmt = conn.prepareStatement(query);
			preStmt.setString(1, id); 
			
			//���� ����
			ResultSet rs = preStmt.executeQuery();
			
			if(rs.next()){
				String user_id = rs.getString("id");
				String user_pw = rs.getString("password");
				Integer user_type = rs.getInt("user_type");
				
				//���� �ش� ���̵�� ��й�ȣ�� ���� ����� ���� ��� -> �α��� ����
				if(user_pw.equals(pw) && user_id.equals(id)){
					session.setAttribute("id", id); // ���ǿ� id ����
					session.setAttribute("user_type", user_type); //���ǿ� user_type ����
					
					//�޼��� �ڽ� -> ����â���� �̵�
					out.println("<script>");
					out.println("alert('�α��� �Ǿ����ϴ�!')");
					out.println("location.href='Main.jsp'");
					out.println("</script>");
				}else{ //�α��� ����(��й�ȣ ����) -> �ٽ� �α���â���� ���ư�
					out.println("<script>");
					out.println("alert('PW�� ��ġ�����ʽ��ϴ�! �ٽ� �ѹ� Ȯ�� �� �α��� ���ּ���')");
					out.println("location.href='Login.jsp'");
					out.println("</script>");
					
				}
			}else{ //���� ���� <- ���̵�� ��ġ�ϴ� �׸� ����
				out.println("<script>");
				out.println("alert('ID�� ��ϵǾ����� �ʽ��ϴ�! �ٽ� �ѹ� Ȯ�� �� �α��� ���ּ���')");
				out.println("location.href='Login.jsp'");
				out.println("</script>");
			}
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
</body>
</html>