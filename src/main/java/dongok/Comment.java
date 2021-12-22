package dongok;

public class Comment {

	public int comment_id;
	public int post_id;
	public String comment_content;
	public String comment_writer_id;
	
	public Comment(int comment_id, int post_id, String comment_content, String comment_writer_id) {
		this.comment_id = comment_id;
		this.post_id = post_id;
		this.comment_content = comment_content;
		this.comment_writer_id = comment_writer_id;
	}
	
	public Comment(int post_id, String comment_content, String comment_writer_id) {
		this.post_id = post_id;
		this.comment_content = comment_content;
		this.comment_writer_id = comment_writer_id;
	}
	
	public Comment(int comment_id) {
		this.comment_id = comment_id;
	}
	
	
	public Comment() {
		
	}
}
