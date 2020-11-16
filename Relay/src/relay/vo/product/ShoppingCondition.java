package relay.vo.product;

public class ShoppingCondition {

	private String word;
	private int display;
	private int start;
	private String sort;
	
	public ShoppingCondition(String word, int display, int start, String sort) {
		this.word = word;
		this.display = display;
		this.start = start;
		this.sort = sort;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	public int getDisplay() {
		return display;
	}

	public void setDisplay(int display) {
		this.display = display;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

}
