<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>영상 및 튜터 검색창</title>
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
			<!-- 검색창 -->
			<tr>
				<td>
					<input type="text" name="input_searchThing" placeholder="검색할 튜터 또는 영상" maxlength="50" size="50">
					<input type="submit" value="검색하기">
				</td>
			</tr>
		</table>
	</form>
	
	

	<%
			//DB연동
			String jdbcDriver="jdbc:mariadb://localhost:3307/dbswvideo";
			String dbUser="root";
			String dbPass="cjy23086";
			
			Connection conn = null;
			PreparedStatement preStmt = null;
			PreparedStatement preStmt2 = null;
			
			// 검색창에 입력된 값 가져오기
			request.setCharacterEncoding("euc-kr");
			String rKey = request.getParameter("input_searchThing");
			String search_key = "%" + rKey + "%"; // 해당 글자가 들어간 위치 상관 없이 검색
			
			// 쿼리 : user 테이블에서 튜터(type=1) 이면서 사용자 이름 x
			String search_tutor = "select * from user where user_type = 1 and name like ?";
			
			// 쿼리 : post 테이블에서 영상이름 
			String search_video = "select * from post where post_title like ?";
			
			try{
				String driver="org.mariadb.jdbc.Driver";
				Class.forName(driver);
				conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
				
				preStmt = conn.prepareStatement(search_tutor);
				%>
				
				<!-- 검색에 대한 결과 창 중 튜터, 분류 -->
				<table border="8" bordercolor="#E6E6FA" style="margin-left:auto; margin-right:auto;">
					<tr align="center">
						<td>튜터 이름</td>
						<td>튜터 아이디</td>
					</tr>
				<% 
					// 검색 결과 값을 쿼리에 대입
					preStmt.setString(1, search_key);
					
					//쿼리 실행
					ResultSet rs = preStmt.executeQuery();
					
					if(rs.next()){
						do{
						String tutor_name = rs.getString("name");
						String tutor_id = rs.getString("id");
				%>
				
				<!-- 검색에 대한 결과창 중 튜터, 결과값 -->
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
					}else{ // 튜터에 대한 결과가 없을 경우
			%>
			<tr align="center">
				<td colspan="2">
					<h1>튜터에 대한 결과 없음</h1>
				</td>
			</tr>
				
			<%
				} //else
			%>
			</table> 
			<hr width="50%"> <!-- 튜터에 대한 검색결과 끝 & 가로선-->
			
			
			<%
				preStmt2 = conn.prepareStatement(search_video);
			%>
			
			<!-- 검색에 대한 결과 창 중 영상, 분류 -->
				<table border="8" bordercolor="#E6E6FA" style="margin-left:auto; margin-right:auto;">
					<tr align="center">
						<td>영상 제목</td>
						<td>영상 상세 정보</td>
					</tr>
					
			<%
				// 쿼리에 검색결과 값을 넘겨줌
				preStmt2.setString(1, search_key);
			
				// 쿼리 실행
				ResultSet rs2 = preStmt2.executeQuery();
				
				if(rs2.next()){
					do{
						String video_title = rs2.getString("post_title");
						String video_content = rs2.getString("post_content");
						String video_postid = rs2.getString("post_id");
			%>
				<!-- 검색에 대한 결과창 중 영상, 결과값 -->
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
				}else{ // 영상에 대한 검색 결과가 없을 때 
			%>
			<tr align="center">
				<td colspan="2">
					<h1>영상에 대한 결과 없음</h1>
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