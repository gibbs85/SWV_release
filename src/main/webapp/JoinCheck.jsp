<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>회원가입 정보 확인</title>
</head>
<body>
	<%
		//DB연동
		String jdbcDriver="jdbc:mariadb://localhost:3306/dbswvideo";
		String dbUser="root";
		String dbPass="2015211131";
		
		Connection conn = null;
		PreparedStatement preStmt = null;
		PreparedStatement preStmt2 = null;
		String query = "insert into user (id, password, name, email, user_type)";
		query += " values (?, ?, ?, ?, ?);";
		String query2 = "select * from user where id = ?"; // 혹시나 ID 중복 확인을 안하고 회원가입을 진행할 경우
		
		int updateCount = 0;
		
		try{
			String driver="org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			preStmt = conn.prepareStatement(query);
			preStmt2 = conn.prepareStatement(query2);
			
			//UserJoin.jsp 로 부터 정보 가져옴
			request.setCharacterEncoding("euc-kr"); //글자깨짐 방지
			String id = request.getParameter("new_id");
			String pw = request.getParameter("new_pw");
			String chk_pw = request.getParameter("chk_pw");
			String name = request.getParameter("new_name");
			String email = request.getParameter("new_email");
			String user_type = request.getParameter("new_userType");
			
			
			//만약 넘어온 값 중 null이 있다면
			if(id==""){
				out.println("<script>");
				out.println("alert('아이디를 입력해주세요!')");
				out.println("location.href='UserJoin.jsp'");
				out.println("</script>");
			}else if(pw==""){
				out.println("<script>");
				out.println("alert('비밀번호를 입력해주세요!')");
				out.println("location.href='UserJoin.jsp'");
				out.println("</script>");
			}else if(name==""){
				out.println("<script>");
				out.println("alert('이름을 입력해주세요!')");
				out.println("location.href='UserJoin.jsp'");
				out.println("</script>");
			}else if(email==""){
				out.println("<script>");
				out.println("alert('이메일을 입력해주세요!')");
				out.println("location.href='UserJoin.jsp'");
				out.println("</script>");
			}
			
			
			else{ // id 및 비밀번호 확인 처리 & 회원가입 완료
				
				//id 중복 확인
				preStmt2.setString(1, id); // 첫번째 ? = id
				ResultSet rs = preStmt2.executeQuery();
				
				if(rs.next()){ // 동일한 id를 가진 사람이 있을 경우
					out.println("<script>");
					out.println("alert('이미 동일한 ID가 사용되고 있습니다. 아이디 중복 확인 후 다시 시도해주세요.')");
					out.println("location.href='UserJoin.jsp'");
					out.println("</script>");
				}
				
				else{ // 비밀번호 확인
					if(pw.equals(chk_pw)){ // 비밀번호 확인과 일치 확인 -> 회원가입 진행
						//쿼리에서 처리할 값
						preStmt.setString(1, id);
						preStmt.setString(2, pw);
						preStmt.setString(3, name);
						preStmt.setString(4, email);
						preStmt.setInt(5, Integer.parseInt(user_type));
						
						// 쿼리 실행 -> 변경된 행 수 = updateCount
						updateCount = preStmt.executeUpdate();
						
						if(updateCount != 0){ // 쿼리 처리 성공 -> 메인화면으로 돌아가기
							out.println("<script>");
							out.println("alert('회원가입에 성공했습니다!')");
							out.println("location.href='Login.jsp'");
							out.println("</script>");
						}else{ // 쿼리 처리 실패 -> 회원가입 페이지로 돌아가기
							out.println("<script>");
							out.println("alert('회원가입에 실패했습니다! 다시 시도하세요.')");
							out.println("location.href='UserJoin.jsp'");
							out.println("</script>");
						}
					}else{ // 비밀번호 확인과 불일치 -> 확인요망 메세지창
						out.println("<script>");
						out.println("alert('PW가 일치하지 않습니다! 다시 한번 확인 해주세요.')");
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