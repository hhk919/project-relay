package relay.vo.reply;

import java.util.Date;

public class ReplyVO {
	private String bno;
	private String cno;
	private String mno;
	private String ccontent;
	private String creplyer;
	private Date cdate;
	private Date cupdate;

	public String getBno() {
		return bno;
	}

	public void setBno(String bno) {
		this.bno = bno;
	}

	public String getCno() {
		return cno;
	}

	public void setCno(String cno) {
		this.cno = cno;
	}

	public String getCcontent() {
		return ccontent;
	}

	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}

	public String getCreplyer() {
		return creplyer;
	}

	public void setCreplyer(String creplyer) {
		this.creplyer = creplyer;
	}

	public Date getCdate() {
		return cdate;
	}

	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}

	public Date getCupdate() {
		return cupdate;
	}

	public void setCupdate(Date cupdate) {
		this.cupdate = cupdate;
	}

	public String getMno() {
		return mno;
	}

	public void setMno(String mno) {
		this.mno = mno;
	}

}
