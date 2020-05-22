package relay.vo.board;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {
	private Long bno;
	private String btitle;
	private String bcontent;
	private String mno;
	private String nick;
	private Date bdate;
	private Date bupdate;
	private String btag;
	private String bimg;
	private String bimgurl;
	private int bcnt;
	private int bvis;
	private int breplycnt;

	private MultipartFile file;

	public Long getBno() {
		return bno;
	}

	public void setBno(Long bno) {
		this.bno = bno;
	}

	public String getBtitle() {
		return btitle;
	}

	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}

	public String getBcontent() {
		return bcontent;
	}

	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
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

	public Date getBdate() {
		return bdate;
	}

	public void setBdate(Date bdate) {
		this.bdate = bdate;
	}
	
	public Date getBupdate() {
		return bupdate;
	}

	public void setBupdate(Date bupdate) {
		this.bupdate = bupdate;
	}

	public String getBtag() {
		return btag;
	}

	public void setBtag(String btag) {
		this.btag = btag;
	}

	public String getBimg() {
		return bimg;
	}

	public void setBimg(String bimg) {
		this.bimg = bimg;
	}

	public String getBimgurl() {
		return bimgurl;
	}

	public void setBimgurl(String bimgurl) {
		this.bimgurl = bimgurl;
	}
	
	public int getBvis() {
		return bvis;
	}

	public void setBvis(int bvis) {
		this.bvis = bvis;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public int getBreplycnt() {
		return breplycnt;
	}

	public void setBreplycnt(int breplycnt) {
		this.breplycnt = breplycnt;
	}
	
	public int getBcnt() {
		return bcnt;
	}
	
	public void setBcnt(int bcnt) {
		this.bcnt = bcnt;
	}

	
}
