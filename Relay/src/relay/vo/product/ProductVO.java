package relay.vo.product;

public class ProductVO {

//	private long pno;
	private long pid;
	private String pname;
	private int phprice;
	private int plprice;
	private String pmall;
	private String pmallurl;
	private String pimg;
	private String cat;
	private long catid;
	private String tags;

	public ProductVO() {
		this.pid = 0L;
		this.pname = "";
		this.phprice = 0;
		this.plprice = 0;
		this.pmall = "";
		this.pmallurl = "";
		this.pimg = "";
		this.cat = "";
		this.catid = 0L;
		this.tags = "";
	}

	public ProductVO(long pid, String pname, int phprice, int plprice, String pmall, String pmallurl, String pimg,
			String cat, long catid, String tags) {
		this.pid = pid;
		this.pname = pname;
		this.phprice = phprice;
		this.plprice = plprice;
		this.pmall = pmall;
		this.pmallurl = pmallurl;
		this.pimg = pimg;
		this.cat = cat;
		this.catid = catid;
		this.tags = tags;
	}

//	public long getPno() {
//		return pno;
//	}
//
//	public void setPno(long pno) {
//		this.pno = pno;
//	}

	public long getPid() {
		return pid;
	}

	public void setPid(long pid) {
		this.pid = pid;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public int getPhprice() {
		return phprice;
	}

	public void setPhprice(int phprice) {
		this.phprice = phprice;
	}

	public int getPlprice() {
		return plprice;
	}

	public void setPlprice(int plprice) {
		this.plprice = plprice;
	}

	public String getPmall() {
		return pmall;
	}

	public void setPmall(String pmall) {
		this.pmall = pmall;
	}

	public String getPmallurl() {
		return pmallurl;
	}

	public void setPmallurl(String pmallurl) {
		this.pmallurl = pmallurl;
	}

	public String getPimg() {
		return pimg;
	}

	public void setPimg(String pimg) {
		this.pimg = pimg;
	}

	public String getCat() {
		return cat;
	}

	public void setCat(String cat) {
		this.cat = cat;
	}

	public long getCatid() {
		return catid;
	}

	public void setCatid(long catid) {
		this.catid = catid;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

}
