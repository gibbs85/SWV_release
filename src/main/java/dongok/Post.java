package dongok;

public class Post {
	public int post_id;
	public String dir_video;
	public String post_title;
	public String post_content;
	public String post_date;
	public String writer_id;
	
	public Post(int post_id, String dir_video, String post_title, String post_content, String post_date, String writer_id) {
		this.post_id = post_id;
		this.dir_video = dir_video;
		this.post_title = post_title;
		this.post_content = post_content;
		this.post_date = post_date;
		this.writer_id = writer_id;
	}
	
	public Post(String dir_video, String post_title, String post_content, String post_date, String writer_id) {
		this.dir_video = dir_video;
		this.post_title = post_title;
		this.post_content = post_content;
		this.post_date = post_date;
		this.writer_id = writer_id;
	}
	
	public Post() {
		//empty Post
	}
}
