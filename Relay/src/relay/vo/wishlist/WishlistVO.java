package relay.vo.wishlist;

import java.util.List;

import org.springframework.data.annotation.PersistenceConstructor;
import org.springframework.data.mongodb.core.index.CompoundIndex;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import relay.vo.member.MemberVO;
import relay.vo.product.ProductVO;



@Document(collection = "wishlist")
@CompoundIndex(def = "{'member.id':1,'items.pid':-1}")
public class WishlistVO {

	@Field("member")
	private MemberVO member;
	@Field("items")
	private List<ProductVO> items;

	@PersistenceConstructor
	public WishlistVO(MemberVO member, List<ProductVO> items) {
		this.member = member;
		this.items = items;
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

	@Override
	public String toString() {
		return "WishlistVO [member=" + member + ", items=" + items + "]";
	}

}
