package dongok;

public class User {
	String id;
	String password;
	String name;
	String email;
	int user_type;
	String message;
	
	public User(String id, String password, String name, String email, int user_type, String message){
		this.id = id;
		this.password = password;
		this.name = name;
		this.email = email;
		this.user_type = user_type;
		this.message = message;
	}
	
	public String getName() {
		return this.name;
	}
	
	public String getEmail() {
		return this.email;
	}
	
	public String getMessage() {
		return this.message;
	}

}
