<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>ȸ������ ���� Ȯ��</title>
</head>
<body>
	<%
		//DB����
		String jdbcDriver="jdbc:mariadb://localhost:3306/dbswvideo";
		String dbUser="root";
		String dbPass="2015211131";
		
		Connection conn = null;
		PreparedStatement preStmt = null;
		PreparedStatement preStmt2 = null;
		String query = "insert into user (id, password, name, email, user_type)";
		query += " values (?, ?, ?, ?, ?);";
		String query2 = "select * from user where id = ?"; // Ȥ�ó� ID �ߺ� Ȯ���� ���ϰ� ȸ�������� ������ ���
		
		int updateCount = 0;
		
		try{
			String driver="org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			preStmt = conn.prepareStatement(query);
			preStmt2 = conn.prepareStatement(query2);
			
			//UserJoin.jsp �� ���� ���� ������
			request.setCharacterEncoding("euc-kr"); //���ڱ��� ����
			String id = request.getParameter("new_id");
			String pw = request.getParameter("new_pw");
			String chk_pw = request.getParameter("chk_pw");
			String name = request.getParameter("new_name");
			String email = request.getParameter("new_email");
			String user_type = request.getParameter("new_userType");
			
			
			//���� �Ѿ�� �� �� null�� �ִٸ�
			if(id==""){
				out.println("<script>");
				out.println("alert('���̵� �Է����ּ���!')");
				out.println("location.href='UserJoin.jsp'");
				out.println("</script>");
			}else if(pw==""){
				out.println("<script>");
				out.println("alert('��й�ȣ�� �Է����ּ���!')");
				out.println("location.href='UserJoin.jsp'");
				out.println("</script>");
			}else if(name==""){
				out.println("<script>");
				out.println("alert('�̸��� �Է����ּ���!')");
				out.println("location.href='UserJoin.jsp'");
				out.println("</script>");
			}else if(email==""){
				out.println("<script>");
				out.println("alert('�̸����� �Է����ּ���!')");
				out.println("location.href='UserJoin.jsp'");
				out.println("</script>");
			}
			
			
			else{ // id �� ��й�ȣ Ȯ�� ó�� & ȸ������ �Ϸ�
				
				//id �ߺ� Ȯ��
				preStmt2.setString(1, id); // ù��° ? = id
				ResultSet rs = preStmt2.executeQuery();
				
				if(rs.next()){ // ������ id�� ���� ����� ���� ���
					out.println("<script>");
					out.println("alert('�̹� ������ ID�� ���ǰ� �ֽ��ϴ�. ���̵� �ߺ� Ȯ�� �� �ٽ� �õ����ּ���.')");
					out.println("location.href='UserJoin.jsp'");
					out.println("</script>");
				}
				
				else{ // ��й�ȣ Ȯ��
					if(pw.equals(chk_pw)){ // ��й�ȣ Ȯ�ΰ� ��ġ Ȯ�� -> ȸ������ ����
						//�������� ó���� ��
						preStmt.setString(1, id);
						preStmt.setString(2, pw);
						preStmt.setString(3, name);
						preStmt.setString(4, email);
						preStmt.setInt(5, Integer.parseInt(user_type));
						
						// ���� ���� -> ����� �� �� = updateCount
						updateCount = preStmt.executeUpdate();
						
						if(updateCount != 0){ // ���� ó�� ���� -> ����ȭ������ ���ư���
							out.println("<script>");
							out.println("alert('ȸ�����Կ� �����߽��ϴ�!')");
							out.println("location.href='Login.jsp'");
							out.println("</script>");
						}else{ // ���� ó�� ���� -> ȸ������ �������� ���ư���
							out.println("<script>");
							out.println("alert('ȸ�����Կ� �����߽��ϴ�! �ٽ� �õ��ϼ���.')");
							out.println("location.href='UserJoin.jsp'");
							out.println("</script>");
						}
					}else{ // ��й�ȣ Ȯ�ΰ� ����ġ -> Ȯ�ο�� �޼���â
						out.println("<script>");
						out.println("alert('PW�� ��ġ���� �ʽ��ϴ�! �ٽ� �ѹ� Ȯ�� ���ּ���.')");
						out.println("location.href='UserJoin.jsp'");
						out.println("</script>");
					}
				}
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