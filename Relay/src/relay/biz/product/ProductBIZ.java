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
	// jsoup으로 scraping하기 위한 connection 객체
	private static Connection jsoupconn;

	// cat, catid, tags를 scarping하여 array에 추고 return
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
			
			// API에서 제공하는 상품URL : https://search.shopping.naver.com/gate.nhn?id=*******
			// 위 주소를 connection으로 open해서 return 받은 response :
//				e.g. :
//				<html>
//				 <head></head>
//				 <body> 
//				  <script> --> javascript 코드
//				  location.replace('/detail/detail.nhn?cat_id=50001897&nv_mid=9274857063');
//				</script> 
//				 </body>
//				</html>
			String newpart = doc.getElementsByTag("script").html().split("'")[1].replace("/detail.", "/lite.");
			// newpart = /detail/detail.nhn?cat_id=******&nv_mid=******
			String catid = newpart.split("=")[1].split("&")[0];
			url = "https://search.shopping.naver.com" + newpart;
			// 따라서 tags를 가져 올 수 없어 다시 새로운 주소로 connect하여 정보를 받아옴
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
			// array 내 각 jsonobject에 catid(카테고리번호), cat(카테고리 이름), tags(태그)를 추가(put)
			obj.put("cat_id",catid);
			obj.put("cat", cat);
			obj.put("tags", tags);
			// cat과 tags는 위에서 concat으로 내용을 추가하기 때문에 매번 한번씩 초기화 시키줘야한다.
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
			System.out.println(count + "개 상품 추가 완료");
			return count;

		} else {
			System.out.println("추가 실패");
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
