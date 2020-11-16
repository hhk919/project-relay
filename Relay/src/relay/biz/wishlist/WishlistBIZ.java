package relay.biz.wishlist;

import java.util.List;
import org.bson.BasicBSONObject;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import relay.dao.wishlist.WishlistDAO;
import relay.vo.member.MemberVO;
import relay.vo.product.ProductVO;

@Service
public class WishlistBIZ {
	
	@Autowired
	WishlistDAO dao;

	public List<ProductVO> getList(String memberId) {
		return dao.getList(memberId);
	}

	public int getTotal(String memberId) {
		return dao.getTotal(memberId);
	}
	
	public int insertWishlist(JSONObject data, MemberVO member) {
		member.setPw("******");
		data.replace("pid", data.get("pid"), Long.parseLong((String)data.get("pid")));
		data.replace("phprice", data.get("phprice"), Integer.parseInt((String)data.get("phprice")));
		data.replace("plprice", data.get("plprice"), Integer.parseInt((String)data.get("plprice")));
		return dao.insertWishlist(member, data);
	}

	public int deleteWishlist(long pid, String memberId) {
		return dao.deleteWishlist(pid, memberId);
	}

	public int updateGrade(long pid, String memberId, int grade) {
		return dao.updateGrade(pid, memberId, grade);
	}

	public List<BasicBSONObject> getMostWishedList() {
		return dao.getMostWishedList();
	}


}
