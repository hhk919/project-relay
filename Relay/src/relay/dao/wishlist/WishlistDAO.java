package relay.dao.wishlist;

import java.util.List;

import org.bson.BSONObject;
import org.bson.BasicBSONObject;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import relay.vo.member.MemberVO;
import relay.vo.product.ProductVO;
import relay.vo.wishlist.WishlistVO;

//import org.apache.log4j.Logger;

@Repository
public class WishlistDAO {

//	private static final Logger logger = Logger.getLogger(MongoTemplate.class);

	@Autowired
	private MongoTemplate wishlist_template;

	public int getTotal(String memberId) {
		int result = wishlist_template.findOne(new Query(Criteria.where("member.id").is(memberId)),WishlistVO.class,"wishlist").getCnt();
		return result;
	}

	public List<ProductVO> getList(String memberId) {
		List<ProductVO> wishlist = null;
		Query query = new Query(Criteria.where("member.id").is(memberId));
		WishlistVO result = wishlist_template.findOne(query, WishlistVO.class, "wishlist");
		if (result != null) {
			wishlist = result.getItems();
		}

		return wishlist;
	}

	public List<BasicBSONObject> getMostWishedList() {
		Query query = new Query();
		query.fields().include("items.pname").include("items.pmallurl").include("items.pimg").include("items.cat")
				.exclude("_id");
		List<BasicBSONObject> result = (List<BasicBSONObject>) wishlist_template.findOne(query, BasicBSONObject.class, "mostwished").get("items");
		return result;
	}

	public int insertWishlist(MemberVO member, JSONObject item) {
		Query query = new Query(Criteria.where("member.id").is(member.getId()));
		Update update = new Update().set("member", member).addToSet("items", item).inc("cnt", 1);
		int result = wishlist_template.upsert(query, update, WishlistVO.class, "wishlist").getN();
		return result;
	}

	public int deleteWishlist(long pid, String memberId) {
		Query query = new Query(Criteria.where("member.id").is(memberId));
		BSONObject itemId = new BasicBSONObject();
		itemId.put("pid", pid);
		Update update = new Update().pull("items", itemId).inc("cnt", -1);
		int result = wishlist_template.updateFirst(query, update, "wishlist").getN();
		return result;
	}

	public int updateGrade(long pid, String memberId, int grade) {
		Query query = new Query(Criteria.where("member.id").is(memberId).and("items.pid").is(pid));
		Update update = new Update().set("items.$.grade", grade);
		int result = wishlist_template.updateFirst(query, update, "wishlist").getN();
		return result;
	}

}
