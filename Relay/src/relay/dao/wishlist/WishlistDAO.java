package relay.dao.wishlist;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.bson.BSONObject;
import org.bson.BasicBSONObject;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import static org.springframework.data.mongodb.core.aggregation.Aggregation.*;
import static org.springframework.data.domain.Sort.Direction.*;


import relay.mapper.wishlist.WishlistMapper;
import relay.vo.member.MemberVO;
import relay.vo.product.ProductVO;
import relay.vo.relay.RelayVO;
import relay.vo.wishlist.WishlistVO;
import relay.vo.wishlist.WishlistVO;

@Repository
public class WishlistDAO {
	
	@Autowired
	private MongoTemplate wishlisttemplate;
	
	
	public int getTotal(String memberId) {
		int cnt = 0;
		Query query = new Query(Criteria.where("member.id").is(memberId));
		WishlistVO result = wishlisttemplate.findOne(query,WishlistVO.class,"wishlist");
		if (result != null) {
			cnt = result.getItems().size();
		}
		return cnt;
	}
	
	public List<ProductVO> getList(String memberId) {
		List<ProductVO> wishlist = null;
		Query query = new Query(Criteria.where("member.id").is(memberId));
		WishlistVO result = wishlisttemplate.findOne(query, WishlistVO.class,"wishlist");
		if (result != null) {
			wishlist = result.getItems();
		}

		return wishlist;
	}
	public List<BasicBSONObject> getMostWishedList() {
		Query query = new Query();
		query.fields().include("pname").include("plprice").include("pmallurl").include("pimg").include("cat").exclude("_id");
		List<BasicBSONObject> result = wishlisttemplate.find(query,BasicBSONObject.class,"mostwished");
		return result;
	}
	
	public int insertWishlist(MemberVO member, JSONObject item) {
		Query query = new Query(Criteria.where("member.id").is(member.getId()));
		Update update = new Update().set("member",member).addToSet("items", item);
		int result = wishlisttemplate.upsert(query, update, WishlistVO.class, "wishlist").getN();
		return result;
	}

	public int deleteWishlist(long pid, String memberId) {
		Query query = new Query(Criteria.where("member.id").is(memberId));
		BSONObject itemId = new BasicBSONObject();
		itemId.put("pid", pid);
		Update update = new Update().pull("items",itemId);
		int result = wishlisttemplate.updateFirst(query, update, "wishlist").getN();
		return result;
	}


	public int updateGrade(long pid, String memberId, int grade) {
		Query query = new Query(Criteria.where("member.id").is(memberId).and("items.pid").is(pid));
		Update update = new Update().set("items.$.grade", grade);
		int result = wishlisttemplate.updateFirst(query, update, "wishlist").getN();
		return result;
	}


	
	
}
