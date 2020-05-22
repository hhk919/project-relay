package relay.dao.relay;

import java.text.DecimalFormat;
import java.util.List;

import org.bson.BasicBSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import static org.springframework.data.mongodb.core.aggregation.Aggregation.match;
import static org.springframework.data.mongodb.core.aggregation.Aggregation.newAggregation;
import static org.springframework.data.mongodb.core.aggregation.Aggregation.project;

import relay.vo.product.ProductVO;
import relay.vo.relay.RelayVO;
import relay.vo.relay.Sender;
import relay.vo.member.Person;

@Repository
public class RelayDAO {

	@Autowired
	private MongoTemplate giftlisttemplate;
	
	public boolean create(RelayVO relayvo) {
		boolean result = false;
		try {
			giftlisttemplate.save(relayvo);
			result = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
		
	public List<BasicBSONObject> getInfo(String memberId) {
		List<BasicBSONObject> result = null;
		try {
			Aggregation agg = newAggregation(match(Criteria.where("senders.memberId").is(memberId)),project("listId").and("recipient.name").as("recipient"));
			result = giftlisttemplate.aggregate(agg,"giftlist",BasicBSONObject.class).getMappedResults();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	public RelayVO getDetail(String listId) {
		Query query = new Query(Criteria.where("listId").is(listId));
		RelayVO result = giftlisttemplate.findOne(query, RelayVO.class,"giftlist");
		return result;
	}

	public RelayVO addSender(String listId, Sender sender) {
		Query query = new Query(Criteria.where("listId").is(listId));
		Update update = new Update().push("senders", sender);
		RelayVO result = giftlisttemplate.findAndModify(query, update, RelayVO.class);
		return result;
	}
	
	public RelayVO updateRecipient(String listId, Person recipient) {
		Query query = new Query(Criteria.where("listId").is(listId));
		Update update = Update.update("recipient", recipient);
		RelayVO result = giftlisttemplate.findAndModify(query, update, RelayVO.class);
		return result;
	}

	public int updateGift(String listId, String memberId, ProductVO gift) {
		Query query = new Query(
				Criteria.where("listId").is(listId).andOperator(Criteria.where("senders.memberId").is(memberId)));
		Update update = new Update().set("senders.$.gift", gift);
		int result = giftlisttemplate.updateFirst(query, update, RelayVO.class,"giftlist").getN();
		return result;
	}

	public RelayVO updateMessage(String listId, String memberId, String message) {
		Query query = new Query(Criteria.where("listId").is(listId).andOperator(Criteria.where("senders.memberId").is(memberId)));
		Update update = new Update().set("senders.$.message", message);
		RelayVO result = giftlisttemplate.findAndModify(query, update, RelayVO.class);
		return result;
	}	

	public long deleteByListId(String listId) {
		Query query = new Query(Criteria.where("listId").is(listId));
		long result = giftlisttemplate.remove(query, RelayVO.class).getN();
		return result;
	}

	public int deleteSender(String listId, String memberId) {
		Query query = new Query(
				Criteria.where("listId").is(listId).andOperator(Criteria.where("senders.memberId").is(memberId)));
		Update update = new Update().pull("senders", Query.query(Criteria.where("memberId").is(memberId)));
		int result = giftlisttemplate.updateFirst(query, update, RelayVO.class,"giftlist").getN();
		return result;
	}

	public String progress(String listId) {
		Query query = new Query(Criteria.where("listId").is(listId));
		RelayVO result = giftlisttemplate.findOne(query, RelayVO.class);
		int sendercount = result.getSenders().size();
		
		return sendercount+"/";
	}

	public long listcount(String memberId) {
		Query query = new Query(Criteria.where("listId").regex("^" + memberId + "_"));
		long result = giftlisttemplate.count(query, RelayVO.class);
		return result;
	}

	public void updateListId(String listId, String memberId) {
		Query query = new Query(Criteria.where("listId").regex("^"+memberId+"_").andOperator((new Criteria("listId").gt(listId))));
		List<RelayVO> result = giftlisttemplate.find(query,RelayVO.class);
		for (RelayVO res : result) {
	    	String[] sepid = res.getListId().split("_");
	    	String newid = sepid[0]+"_"+new DecimalFormat("0000").format(Long.parseLong(sepid[1])-1);
	    	giftlisttemplate.findAndModify(new Query(Criteria.where("listId").is(res.getListId())), Update.update("listId", newid), RelayVO.class);
	    }
	}	
	
}
