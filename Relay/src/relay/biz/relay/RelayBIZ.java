package relay.biz.relay;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.bson.BasicBSONObject;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import relay.dao.relay.RelayDAO;
import relay.vo.member.Person;
import relay.vo.product.ProductVO;
import relay.vo.relay.RelayVO;
import relay.vo.relay.Sender;

@Service
public class RelayBIZ {
	
	@Autowired
	private RelayDAO dao;
	
	public boolean create(JSONObject relayvo) {
		String memberId = (String)relayvo.get("id");
		
		String num = new DecimalFormat("0000").format(dao.listcount(memberId)+1);
		String listId = memberId+"_"+num;
		
		Person recipient = new Person();
		recipient.setName((String)relayvo.get("name"));
		recipient.setAge(Integer.parseInt((String)relayvo.get("age")));
		recipient.setGender((String)relayvo.get("gender"));
		recipient.setHobby((String)relayvo.get("hobby"));
		
		JSONArray jsonarray = (JSONArray) relayvo.get("senders");
		
		List<Sender> senders = new ArrayList<>();
		ProductVO gift = new ProductVO(); 
		for (int i=0;i<jsonarray.size();i++) {
			int mno = Integer.parseInt((String)((JSONObject)jsonarray.get(i)).get("mno"));
			String senderId = (String)((JSONObject)jsonarray.get(i)).get("memberId");
			String senderNick = (String)((JSONObject)jsonarray.get(i)).get("memberNick");
			senders.add(new Sender(mno, senderId, senderNick, gift));
		}

		RelayVO giftlist = new RelayVO(listId, recipient, senders);
		return dao.create(giftlist);
	}

	public RelayVO addSender(int mno, String listId, String memberId, String memberName, ProductVO gift) {
		Sender sender = new Sender(mno, memberId, memberName, gift);
		return dao.addSender(listId, sender);
	}

	public List<BasicBSONObject> getInfo(String memberId) {
		
		return dao.getInfo(memberId);
	}

	public RelayVO getDetail(String listId) {
		return dao.getDetail(listId);	
	}

	public RelayVO updateRecipient(String listId, Person recipient) {
		return dao.updateRecipient(listId, recipient);
	}

	public int updateGift(HashMap<String, String> data) {
		String listId = data.get("listId");
		String memberId = data.get("memberId");
		ProductVO gift = new ProductVO();
		gift.setPid(Long.parseLong(data.get("pid")));
		gift.setPname(data.get("pname"));
		gift.setPhprice(Integer.parseInt(data.get("phprice")));
		gift.setPlprice(Integer.parseInt(data.get("plprice")));
		gift.setPmall(data.get("pmall"));
		gift.setPmallurl(data.get("pmallurl"));
		gift.setPimg(data.get("pimg"));
		gift.setCat(data.get("cat"));
		gift.setCatid(Long.parseLong(data.get("catid")));
		gift.setTags(data.get("tags"));
		return dao.updateGift(listId, memberId, gift);
	}

	public int updateMessage(String listId, String memberId, String words) {
		return dao.updateMessage(listId, memberId, words);
	}

	public long deleteByListId(String listId, String memberId) {
		long result = dao.deleteByListId(listId);
		dao.updateListId(listId, memberId);
		return result;
	}

	public int deleteSender(String listId, String memberId) {
		return dao.deleteSender(listId, memberId);
	}

	public String progress(String listId) {
		return dao.progress(listId);
	}
	
}
