package relay.dao.product;

import java.util.ArrayList;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;
import relay.common.APISearch;
import relay.vo.product.ShoppingCondition;

@Repository
public class ProductDAO {

	public ArrayList<JSONObject> searchList(ShoppingCondition sc) {
		ArrayList<JSONObject> list = APISearch.searchList(sc);
		return list;
	}
	

}