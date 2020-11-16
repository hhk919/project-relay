package relay.vo.wishlist;

import java.util.List;

import org.springframework.data.annotation.PersistenceConstructor;
import org.springframework.data.mongodb.core.index.CompoundIndex;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import relay.vo.member.MemberVO;
import relay.vo.product.ProductVO;

@Document(collection = "wishlist")
@CompoundIndex(def = "{'member.id':-1}", background=true)
public class WishlistVO {

	@Field("member")
	private MemberVO member;
	@Field("items")
	private List<ProductVO> items;
	@Field("cnt")
	private int cnt;

	@PersistenceConstructor
	public WishlistVO(MemberVO member, List<ProductVO> items, int cnt) {
		this.member = member;
		this.items = items;
		this.cnt = cnt;
	}

	public MemberVO getMember() {
		return member;
	}

	public void setMember(MemberVO member) {
		this.member = member;
	}

	public List<ProductVO> getItems() {
		return items;
	}

	public void setItems(List<ProductVO> items) {
		this.items = items;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

}
