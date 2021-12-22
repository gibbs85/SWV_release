package dongok;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Query {
	
	private String jdbcDriver;
	private String dbUser;
	private String dbPass;
	
	private Connection conn;
	private Statement stmt;
	
	public Query(){
		this.jdbcDriver = "jdbc:mariadb://localhost:3306/dbswvideo";
		this.dbUser = "root";
		this.dbPass = "2015211131";
		
		this.conn = null;
		this.stmt = null;
	}
	
	public ResultSet search_suggested(User tutie) {
		try {
			this.conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			this.stmt = conn.createStatement();
			String statement =
					"SELECT *"
					+" FROM suggestion"
					+" WHERE tutie_id='"+tutie.id+"';";
			ResultSet result = stmt.executeQuery(statement);

			stmt.close();
			conn.close();
			
			return result;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		ResultSet result = null;
		return result;
	}
	
	public Post search_post_byID(int post_id) {
		try {
			this.conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			this.stmt = conn.createStatement();
			String statement =
					"SELECT *"
					+" FROM post"
					+" WHERE post_id='"+post_id+"';";
			ResultSet result = stmt.executeQuery(statement);
			
			if(result.next()) {
				int post_id_got = result.getInt("post_id");
				String dir_video = result.getNString("dir_video");
				String title = result.getNString("post_title");
				String content = result.getNString("post_content");
				String date = result.getNString("post_date");
				String writer_id = result.getNString("writer_id");
				
				Post post = new Post(post_id_got, dir_video, title, content, date, writer_id);
				
				stmt.close();
				conn.close();
				return post;
						}

			stmt.close();
			conn.close();
			
			return null;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public ResultSet search_comment_by_postid(int post_id) {
		try {
			this.conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			this.stmt = conn.createStatement();
			String statement =
					"SELECT comment.comment_id, comment.post_id, comment.comment_content, comment_writer_id"
					+" FROM comment, post"
					+" WHERE comment.post_id = post.post_id AND post.post_id = "+post_id+";";
			ResultSet result = stmt.executeQuery(statement);

			stmt.close();
			conn.close();
			
			return result;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		ResultSet result = null;
		return result;
	}
	
	public ResultSet search_liked_posts_id(User tutie) {
		try {
			this.conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			this.stmt = conn.createStatement();
			String statement =
					"SELECT upvoted_post_id"
					+" FROM upvote"
					+" WHERE upvoter_id='"+tutie.id+"';";
			ResultSet result = stmt.executeQuery(statement);

			stmt.close();
			conn.close();
			
			return result;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		ResultSet result = null;
		return result;
	}
	
	public ResultSet search_user_byID(String user_id) {
		try {
			this.conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			this.stmt = conn.createStatement();
			String statement =
					"SELECT *"
					+" FROM user"
					+" WHERE id='"+user_id+"';";
			ResultSet result = stmt.executeQuery(statement);

			stmt.close();
			conn.close();
			
			return result;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		ResultSet result = null;
		return result;
	}
	
	public ResultSet search_all(Post post) {
		try {
			this.conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			this.stmt = conn.createStatement();
			String statement =
					"SELECT *"
					+" FROM post;";
			ResultSet result = stmt.executeQuery(statement);

			stmt.close();
			conn.close();
			
			return result;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		ResultSet result = null;
		return result;
	}
	
	public ResultSet search_byWriter(User writer) {
		try {
			this.conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			this.stmt = conn.createStatement();
			String statement =
					"SELECT *"
					+" FROM post"
					+" WHERE writer_id = '"+writer.id+"';";
			ResultSet result = stmt.executeQuery(statement);

			stmt.close();
			conn.close();
			
			return result;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		ResultSet result = null;
		return result;
	}
	
	public void insert_value(Post post) {
		try {
			this.conn = DriverManager.getConnection(this.jdbcDriver, this.dbUser, this.dbPass);
			this.stmt = conn.createStatement();
			String statement = "insert into post(post_id, dir_video, post_title, post_content, post_date, writer_id) values("
					+ "'" + post.post_id + "', '" + post.dir_video + "', '"+post.post_title+ "', '"+post.post_content+"', '"+post.post_date+"', '"+post.writer_id+"'"
					+ ");";
			stmt.executeUpdate(statement);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void insert_value(Comment comment) {
		try {
			this.conn = DriverManager.getConnection(this.jdbcDriver, this.dbUser, this.dbPass);
			this.stmt = conn.createStatement();
			String statement = "insert into comment(post_id, comment_content, comment_writer_id) values("
					+ comment.post_id + ", '" + comment.comment_content + "', '"+comment.comment_writer_id+ "'"
					+ ");";
			stmt.executeUpdate(statement);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void insert_value(User user) {
		try {
			this.conn = DriverManager.getConnection(this.jdbcDriver, this.dbUser, this.dbPass);
			this.stmt = conn.createStatement();
			String statement = "insert into user(id, password, name, email, user_type, message) values("
					+ "'" +user.id+ "', '" +user.password+ "', '"+user.name+ "', '"+user.email+"', "+user.user_type+", '"+user.message+"'"
					+ ");";
			System.out.println(statement);
			stmt.executeUpdate(statement);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void insert_value(Upvote upvote) {
		try {
			this.conn = DriverManager.getConnection(this.jdbcDriver, this.dbUser, this.dbPass);
			this.stmt = conn.createStatement();
			String statement = "insert into upvote(upvoter_id, upvoted_post_id, upvote) values("
					+ "'" +upvote.upvoter_id+ "', '" +upvote.upvoted_post_id+"', "+ upvote.upvote
					+ ");";
			System.out.println(statement);
			stmt.executeUpdate(statement);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public boolean check_dup(Upvote upvote) {
		try {
		this.conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		this.stmt = conn.createStatement();
		String statement = 
				"SELECT upvoter_id, upvoted_post_id"
				+" FROM upvote"
				+" WHERE upvoter_id = '" + upvote.upvoter_id + "'"
				+" AND "
				+" upvoted_post_id = '" + upvote.upvoted_post_id + "'";
		ResultSet result = stmt.executeQuery(statement);
		
		if (result.next()) {
			stmt.close();
			conn.close();
			return true;
			}
		else {
			stmt.close();
			conn.close();
			return false;
			}
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
				
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	public boolean check_dup(User user) {
		try {
		this.conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		this.stmt = conn.createStatement();
		String statement = 
				"SELECT id"
				+" FROM user"
				+" WHERE id = '" + user.id + "'";
		ResultSet result = stmt.executeQuery(statement);
		
		if (result.next()) {
			stmt.close();
			conn.close();
			return true;
			}
		else {
			stmt.close();
			conn.close();
			return false;
			}
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
				
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
	
	public boolean check_dup(Post post) {
		try {
		this.conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		this.stmt = conn.createStatement();
		String statement = 
				"SELECT post_id"
				+" FROM post"
				+" WHERE post_id = '" + post.post_id + "'";
		ResultSet result = stmt.executeQuery(statement);
		
		if (result.next()) {
			stmt.close();
			conn.close();
			return true;
			}
		else {
			stmt.close();
			conn.close();
			return false;
			}
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				stmt.close();
				conn.close();
				
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return true;
	}

}
