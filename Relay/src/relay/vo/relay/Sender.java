package relay.vo.relay;

import relay.vo.product.ProductVO;

public class Sender {
	
	private String memberId;
	private String memberNick;
	private ProductVO gift;
	private String message;

	public Sender(String memberId, String memberNick, ProductVO gift) {
		this.memberId = memberId;
		this.memberNick = memberNick;
		this.gift = gift;
		this.message = "���ϰ� ���� �޽����� �Է����ּ���";
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
	
}
