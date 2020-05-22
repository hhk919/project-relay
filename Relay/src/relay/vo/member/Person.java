package relay.vo.member;

public class Person {

	private String name;
	private int age;
	private String gender;
	private String job; // 직업
	private String hobby; // 취미

	public Person() {
		super();
	}

	public Person(String name, int age, String gender, String job, String hobby) {
		this.name = name;
		this.age = age;
		this.gender = gender;
		this.job = job;
		this.hobby = hobby;
	}

	public String getName() {
		return name;
	}

	public int getAge() {
		return age;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getGender() {
		return gender;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public String getHobby() {
		return hobby;
	}

	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

}
