package relay.vo.product;

public class ProductVO {

	private long pid;
	private String pname;
	private int phprice;
	private int plprice;
	private int grade;
	private String pmall;
	private String pmallurl;
	private String pimg;
	private String brand;
	private String cat;
	private String tags;

	public ProductVO() {
		this.pid = 0L;
		this.pname = "";
		this.phprice = 0;
		this.plprice = 0;
		this.grade = 0;
		this.pmall = "";
		this.pmallurl = "";
		this.pimg = "";
		this.brand = "";
		this.cat = "";
		this.tags = "";
	}

	public ProductVO(long pid, String pname, int phprice, int plprice, String pmall, String pmallurl, String pimg,
			String cat, String brand, String tags) {
		this.pid = pid;
		this.pname = pname;
		this.phprice = phprice;
		this.plprice = plprice;
		this.pmall = pmall;
		this.pmallurl = pmallurl;
		this.pimg = pimg;
		this.brand = brand;
		this.cat = cat;
		this.tags = tags;
	}

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

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getCat() {
		return cat;
	}

	public void setCat(String cat) {
		this.cat = cat;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

}
