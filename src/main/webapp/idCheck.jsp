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
		//DB연동 
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
			
			//아이디 중복 창에서 정보 가져옴  
			request.setCharacterEncoding("UTF-8"); //글자깨짐 방지
			String user_id = request.getParameter("check_id");
			
			//쿼리 처리
			preStmt.setString(1, user_id); // 첫번째 ?=user_id
			ResultSet rs = preStmt.executeQuery();
			
			if(rs.next()){ // 동일한 id를 가진 사람이 있을 경우
				out.println("<script>");
				out.println("alert('이미 존재하는 아이디입니다! 다시 시도해주세요.')");
				out.println("location.href='IdConfirm.jsp'"); // 아이디 확인창으로 이동
				out.println("</script>");
			}
			
			else{ // 동일한 id를 가진 사람이 없을 경우
				out.println("<script>");
				out.println("alert('사용 가능한 아이디입니다!')");
				out.println("window.close()"); // 아이디 확인 창 종료 -> 회원가입 창으로 돌아가기
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