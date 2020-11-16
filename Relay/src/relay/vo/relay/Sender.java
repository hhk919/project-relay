package relay.vo.relay;

import relay.vo.product.ProductVO;

public class Sender {

	private int mno;
	private String memberId;
	private String memberNick;
	private ProductVO gift;
	private String message;

	public Sender(int mno, String memberId, String memberNick, ProductVO gift) {
		this.mno = mno;
		this.memberId = memberId;
		this.memberNick = memberNick;
		this.gift = gift;
		this.message = "전하고 싶은 메시지를 입력해주세요";
	}

	public int getMno() {
		return mno;
	}

	public void setMno(int mno) {
		this.mno = mno;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberNick() {
		return memberNick;
	}

	public void setMemberNick(String memberNick) {
		this.memberNick = memberNick;
	}

	public ProductVO getGift() {
		return gift;
	}

	public void setGift(ProductVO gift) {
		this.gift = gift;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "Sender [mno=" + mno + ", memberId=" + memberId + ", memberNick=" + memberNick + ", gift=" + gift
				+ ", message=" + message + "]";
	}

	
}
