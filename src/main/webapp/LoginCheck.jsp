<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인 정보 확인</title>
</head>
<body>
	<%
		//DB 연동
		String jdbcDriver="jdbc:mariadb://localhost:3306/dbswvideo";
		String dbUser="root";
		String dbPass="2015211131";
		
		Connection conn = null;
		PreparedStatement preStmt = null;
		
		try{
			String driver="org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			//login 페이지에서 정보 가져옴
			request.setCharacterEncoding("UTF-8"); //글자깨짐 방지
			String id = request.getParameter("input_id");
			String pw = request.getParameter("input_pw");
			
			//처리할 쿼리
			String query = "select * from user where id = ?";
			preStmt = conn.prepareStatement(query);
			preStmt.setString(1, id); 
			
			//쿼리 실행
			ResultSet rs = preStmt.executeQuery();
			
			if(rs.next()){
				String user_id = rs.getString("id");
				String user_pw = rs.getString("password");
				Integer user_type = rs.getInt("user_type");
				
				//만약 해당 아이디와 비밀번호를 가진 사람이 있을 경우 -> 로그인 성공
				if(user_pw.equals(pw) && user_id.equals(id)){
					session.setAttribute("id", id); // 세션에 id 저장
					session.setAttribute("user_type", user_type); //세션에 user_type 저장
					
					//메세지 박스 -> 메인창으로 이동
					out.println("<script>");
					out.println("alert('로그인 되었습니다!')");
					out.println("location.href='Main.jsp'");
					out.println("</script>");
				}else{ //로그인 실패(비밀번호 오류) -> 다시 로그인창으로 돌아감
					out.println("<script>");
					out.println("alert('PW가 일치하지않습니다! 다시 한번 확인 후 로그인 해주세요')");
					out.println("location.href='Login.jsp'");
					out.println("</script>");
					
				}
			}else{ //쿼리 실패 <- 아이디와 일치하는 항목 없음
				out.println("<script>");
				out.println("alert('ID가 등록되어있지 않습니다! 다시 한번 확인 후 로그인 해주세요')");
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