package relay.vo.message;

import java.util.Date;

public class MessageVO {

	private int sno;
	private int sender;
	private String snick;
	private int receiver;
	private String rnick;
	private int sstate;
	private String stitle;
	private String scontent;
	private Date sdate;

	public int getSno() {
		return sno;
	}

	public void setSno(int sno) {
		this.sno = sno;
	}

	public int getSender() {
		return sender;
	}

	public void setSender(int sender) {
		this.sender = sender;
	}
	
	public String getRnick() {
		return rnick;
	}

	public void setRnick(String rnick) {
		this.rnick = rnick;
	}

	public int getReceiver() {
		return receiver;
	}

	public void setReceiver(int receiver) {
		this.receiver = receiver;
	}
	
	public String getSnick() {
		return snick;
	}

	public void setSnick(String snick) {
		this.snick = snick;
	}

	public int getSstate() {
		return sstate;
	}

	public void setSstate(int sstate) {
		this.sstate = sstate;
	}

	public String getStitle() {
		return stitle;
	}

	public void setStitle(String stitle) {
		this.stitle = stitle;
	}

	public String getScontent() {
		return scontent;
	}

	public void setScontent(String scontent) {
		this.scontent = scontent;
	}

	public Date getSdate() {
		return sdate;
	}

	public void setSdate(Date sdate) {
		this.sdate = sdate;
	}

}
