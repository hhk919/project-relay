package relay.vo.member;

import java.util.Date;

import org.springframework.data.mongodb.core.mapping.Field;

public class MemberVO extends Person {

	private int mno; // 회원번호
	@Field("id")
	private String id; // 아이디
	private String pw; // 패스워드
	private String nick; // 닉네임
	private int birth; // 주민등록번호 앞자리
	private int sex; // 주민번호뒷자리
	private String addr; // 주소
	private Date joindate; // 가입일자
	private Date outdate; // 탈퇴일자
	private long logonTime;

	public MemberVO() {
		super();
	}

	public MemberVO(int mno, String id, String pw, String name, String nick, int birth, int sex, String addr,
			String gender, int age, String job, String hobby, Date joindate, Date outdate) {
		super(name, age, gender,job,hobby);
		this.mno = mno;
		this.id = id;
		this.pw = pw;
		this.nick = nick;
		this.birth = birth;
		this.sex = sex;
		this.addr = addr;
		this.joindate = joindate;
		this.outdate = outdate;
	}

	public int getMno() {
		return mno;
	}

	public void setMno(int mno) {
		this.mno = mno;
	}

//	public int getRno() {
//		return rno;
//	}
//
//	public void setRno(int rno) {
//		this.rno = rno;
//	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public int getBirth() {
		return birth;
	}

	public void setBirth(int birth) {
		this.birth = birth;
	}

	public int getSex() {
		return sex;
	}

	public void setSex(int sex) {
		this.sex = sex;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}


	public Date getJoindate() {
		return joindate;
	}

	public void setJoindate(Date joindate) {
		this.joindate = joindate;
	}

	public Date getOutdate() {
		return outdate;
	}

	public void setOutdate(Date outdate) {
		this.outdate = outdate;
	}

	public long getLogonTime() {
		return logonTime;
	}

	public void setLogonTime(long logonTime) {
		this.logonTime = logonTime;
	}

//	@Override
//	public String toString() {
//		return "MemberVO [mno=" + mno + ", id=" + id + ", pw=" + pw + ", nick=" + nick + ", birth=" + birth + ", sex="
//				+ sex + ", addr=" + addr + ", joindate=" + joindate + ", outdate=" + outdate + ", logonTime="
//				+ logonTime + ", getName()=" + getName() + ", getAge()=" + getAge() + ", getGender()=" + getGender()
//				+ ", getJob()=" + getJob() + ", getHobby()=" + getHobby() + "]";
//	}
	
	
}
