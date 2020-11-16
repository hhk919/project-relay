package relay.biz.product;

import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import relay.dao.product.ProductDAO;
import relay.vo.product.ShoppingCondition;

@Transactional
@Service
public class ProductBIZ {

	@Autowired
	ProductDAO dao;

	public int parseString2int(String str) {
		return Integer.parseInt(str);
	}
	
	public ArrayList<JSONObject> preprocess(ArrayList<JSONObject> arr) {
		for (JSONObject obj : arr) {
			String title = ((String)obj.get("title")).replaceAll("<b/?>", "");
			obj.replace("title", title);
			List<String> sa = new ArrayList<>();
			for (int i=1;i<5;i++) {
				String c = (String)obj.get("category"+i);
				if (c.length() != 0) {
					sa.add(c);
				}
			}
			String cat = "";
			if (sa.size() != 1) {
				cat = String.join(">",sa);
			} else {
				cat = sa.get(0);
			}
			obj.put("cat",cat);
		}
		return arr;
	}
	
	public ArrayList<JSONObject> searchList(ShoppingCondition sc) {
		ArrayList<JSONObject> arr = dao.searchList(sc);
		return preprocess(arr);
	}
	
}