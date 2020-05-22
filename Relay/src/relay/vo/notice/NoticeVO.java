package relay.vo.notice;

import java.util.Date;

public class NoticeVO {
	private Long nno;
	private String ntitle;
	private String ncontent;
	private String mno;
	private String nick;
	private Date ndate;
	private Date nupdate;
	private int nvis;
	private int ncnt;
	
	public Long getNno() {
		return nno;
	}
	public void setNno(Long nno) {
		this.nno = nno;
	}
	public String getNtitle() {
		return ntitle;
	}
	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}
	public String getNcontent() {
		return ncontent;
	}
	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}
	public String getMno() {
		return mno;
	}
	public void setMno(String mno) {
		this.mno = mno;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public Date getNdate() {
		return ndate;
	}
	public void setNdate(Date ndate) {
		this.ndate = ndate;
	}
	public Date getNupdate() {
		return nupdate;
	}
	public void setNupdate(Date nupdate) {
		this.nupdate = nupdate;
	}
	public int getNvis() {
		return nvis;
	}
	public void setNvis(int nvis) {
		this.nvis = nvis;
	}
	public int getNcnt() {
		return ncnt;
	}
	public void setNcnt(int ncnt) {
		this.ncnt = ncnt;
	}
}
