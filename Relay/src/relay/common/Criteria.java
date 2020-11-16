package relay.common;

public class Criteria {
	private int pageNum;
	private int amount;
	private int offset;
	private String type;
	private String keyword;

	public Criteria() {
		this(1, 10, 0);
	}

	public Criteria(int pageNum, int amount, int offset) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.offset = offset;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}

	public int getOffset() {
		return this.offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", offset=" + offset + ", type=" + type
				+ ", keyword=" + keyword + "]";
	}

}
