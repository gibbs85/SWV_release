<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상세정보</title>
</head>
<body>
<%
//DB연동
		String jdbcDriver="jdbc:mariadb://localhost:3307/dbswvideo";
		String dbUser="root";
		String dbPass="2015211131";
		
		Connection conn = null;
		PreparedStatement preStmt = null; //tutor
		PreparedStatement preStmt2 = null; //video
		
		//tutor의 상세정보일 경우
		String tutor_info = "select * from user where id = ? ";
		//video 상세 정보일 경우
		String video_info = "select * from post where post_id = ?";
		
		request.setCharacterEncoding("euc-kr"); //글자깨짐 방지
		String tutor_id = "";
		String video_postid = "";
		tutor_id = request.getParameter("tutor_id");
		video_postid = request.getParameter("video_postid");
		
		try{
			String driver="org.mariadb.jdbc.Driver";
			Class.forName(driver);
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			preStmt = conn.prepareStatement(tutor_info);
			preStmt2 = conn.prepareStatement(video_info);
			
			if(tutor_id != ""){ // tutor에 대한 상세 정보일 경우
				preStmt.setString(1, tutor_id);
				ResultSet rs = preStmt.executeQuery();
				
				while(rs.next()){
		%>
		<table border="8" bordercolor="#FFF0F5" style="margin-left:auto; margin-right:auto;">
			<tr>
				<th> 튜터 이름 </th>
				<th align="left">
					<input type="text" name="input_tName" value="<%=rs.getString("name") %>" maxlength="10" size="50" disabled>
				</th>
			</tr>
			<tr>
				<th> 튜터 아이디 </th>
				<th align="left">
					<input type="text" name="input_tId" value="<%=rs.getString("id") %>" maxlength="20" size="50" disabled>
				</th>
			</tr>
			<tr>
				<th> 튜터 이메일 </th>
				<th align="left">
					<input type="text" name="input_tEmail" value="<%=rs.getString("email") %>" maxlength="50" size="50" disabled>
				</th>
			</tr>
			<tr>
				<th> 튜터 소개 </th>
				<th align="left">
					<textarea name="input_tMessage" rows="5" cols="45" disabled>
						<%=rs.getString("message") %>
					</textarea>
				</th>
			</tr>
		<% 
				} //while
		%>
		</table>
		
		
		<% 
			} //if
			if(video_postid != ""){ //video에 대한 상세 정보일 경우
				preStmt2.setString(1, video_postid);
				ResultSet rs2 = preStmt2.executeQuery();
				
				while(rs2.next()){
		%>
			<table border="8" bordercolor="#FFF0F5" style="margin-left:auto; margin-right:auto;">
				<tr>
					<th> 게시물(영상) 제목 </th>
					<th align="left">
						<input type="text" name="input_vTitle" value="<%=rs2.getString("post_title") %>" maxlength="20" size="50" disabled>
					</th>
				</tr>
				<tr>
					<th> 게시물(영상) 작성자 아이디 </th>
					<th align="left">
						<input type="text" name="input_vWriter" value="<%=rs2.getString("writer_id") %>" maxlength="20" size="50" disabled>
					</th>
				</tr>
				<tr>
					<th> 게시물(영상) 게시일 </th>
					<th align="left">
						<input type="text" name="input_vDate" value="<%=rs2.getString("post_date") %>" maxlength="8" size="50" disabled>
					</th>
				</tr>
				<tr>
					<th> 게시물(영상) 상세정보 </th>
					<th align="left">
						<textarea name="input_vContent" rows="10" cols="45" disabled>
						<%=rs2.getString("post_content") %>
					</textarea>
					</th>
				</tr>
				
		<% 
					}//while
				}	// video if
		}catch(Exception e){ 
			e.printStackTrace();
		}finally{
			try{
				preStmt.close();
				conn.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
		} //try
		%>
		
	</table>
</body>
</html>