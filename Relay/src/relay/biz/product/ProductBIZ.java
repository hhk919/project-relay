package relay.biz.product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.json.simple.JSONObject;
import org.jsoup.Connection;
import org.jsoup.HttpStatusException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import relay.vo.product.ProductVO;
import relay.dao.product.ProductDAO;
import relay.vo.product.ShoppingCondition;

@Transactional
@Service
public class ProductBIZ {

	@Autowired
	ProductDAO dao;
	// jsoup���� scraping�ϱ� ���� connection ��ü
	private static Connection jsoupconn;

	// cat, catid, tags�� scarping�Ͽ� array�� �߰� return
	public ArrayList<JSONObject> crawling(ArrayList<JSONObject> array) throws HttpStatusException, IOException {
		
		Document doc = null;
		String cat = "";
		String tags = "";
		String tag = "";
		for (JSONObject obj : array) {
			int n = 1;
			String url = (String) obj.get("link");
			String title = (String) obj.get("title");
			title = title.replace("<b>", "").replace("</b>", "");
			obj.replace("title", title);

			jsoupconn = Jsoup.connect(url);
			
			doc = jsoupconn.get();
			
			// API���� �����ϴ� ��ǰURL : https://search.shopping.naver.com/gate.nhn?id=*******
			// �� �ּҸ� connection���� open�ؼ� return ���� response :
//				e.g. :
//				<html>
//				 <head></head>
//				 <body> 
//				  <script> --> javascript �ڵ�
//				  location.replace('/detail/detail.nhn?cat_id=50001897&nv_mid=9274857063');
//				</script> 
//				 </body>
//				</html>
			String newpart = doc.getElementsByTag("script").html().split("'")[1].replace("/detail.", "/lite.");
			// newpart = /detail/detail.nhn?cat_id=******&nv_mid=******
			String catid = newpart.split("=")[1].split("&")[0];
			url = "https://search.shopping.naver.com" + newpart;
			// ���� tags�� ���� �� �� ���� �ٽ� ���ο� �ּҷ� connect�Ͽ� ������ �޾ƿ�
			// url =
			// "https://search.shopping.naver.com/detail/detail.nhn?cat_id=*******&nv_mid=*******
			doc = jsoupconn.url(url).get();
			Elements els = doc.select("span.s_nowrap");
			for (Element e : els) {
				cat = cat.concat(e.text() + " ");
			}
			cat = cat.trim().replace(" ", ">");
			els = doc.select("[id^=topic]");
			for (int i = 1; i <= els.size(); i++) {
				tag = "#" + doc.select("#topic" + i + " > a > span").html();
				tags = tags.concat(tag + " ");
				if (i == 5) {
					break;
				}
			}
			tags = tags.trim();
			// array �� �� jsonobject�� catid(ī�װ���ȣ), cat(ī�װ� �̸�), tags(�±�)�� �߰�(put)
			obj.put("cat_id",catid);
			obj.put("cat", cat);
			obj.put("tags", tags);
			// cat�� tags�� ������ concat���� ������ �߰��ϱ� ������ �Ź� �ѹ��� �ʱ�ȭ ��Ű����Ѵ�.
			cat = "";
			tags = "";

		}
		return array;
	}


	public ArrayList<JSONObject> searchList(ShoppingCondition sc){

		ArrayList<JSONObject> list = dao.searchList(sc);
		if (list.isEmpty()) {
			return list;
		} else {
			try {
				list = crawling(list);
				return list;
			} catch(IOException e) {
				return list;
			}
			
		}
	}


	public int insertProductForAdmin(ShoppingCondition sc) {
		ArrayList<JSONObject> list = dao.searchList(sc);

		ProductVO vo = new ProductVO();
		int count = 0;
		for (int i = 0; i < list.size(); i++) {
			JSONObject res = list.get(i);

			vo.setPname((String) res.get("title"));
			vo.setPhprice(Integer.parseInt((String) res.get("hprice")));
			vo.setPlprice(Integer.parseInt((String) res.get("lprice")));
			vo.setPmall((String) res.get("mallName"));
			vo.setPmallurl((String) res.get("link"));
			vo.setPimg((String) res.get("image"));
			vo.setPid(Long.parseLong((String) res.get("productId")));
			vo.setCatid(Long.parseLong((String) res.get("cat_id")));
			vo.setTags((String) res.get("tags"));
			count = count + dao.insertProductForAdmin(vo);
		}
		if (count == list.size()) {
			System.out.println(count + "�� ��ǰ �߰� �Ϸ�");
			return count;

		} else {
			System.out.println("�߰� ����");
		}
		return 0;
	}

	public List<ProductVO> getListForAdmin() {
		List<ProductVO> r = dao.getListForAdmin();
		return r;
	}

	public int insertProduct(ProductVO prd) {
		int r = dao.insertProduct(prd);
		return r;
	}

	public int insertProductForAdmin(ProductVO prd) {
		int r = dao.insertProductForAdmin(prd);

		return r;
	}

	public List<ProductVO> searchListForAdmin(String pname) {
		List<ProductVO> r = dao.searchListForAdmin(pname);
		return r;
	}

	public ProductVO searchProductForAdmin(int update_no) {
		ProductVO prd = dao.searchProductForAdmin(update_no);
		return prd;
	}

	public int updateProductForAdmin(ProductVO prd) {

		int res = dao.updateProductForAdmin(prd);

		return res;
	}

	public int deleteProductForAdmin(int delete_no) {

		int res = dao.deleteProductForAdmin(delete_no);
		return res;
	}

	public ProductVO getProduct(Long pid) {
		ProductVO prd = dao.getProduct(pid);
		return prd;
	}

}
