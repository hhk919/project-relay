package relay.controller.product;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import relay.biz.product.ProductBIZ;
import relay.vo.product.ProductVO;
import relay.vo.product.ShoppingCondition;

@Controller
public class ProductController {

	@Autowired
	ProductBIZ biz;
	
	@RequestMapping(value = "/apisearch.do", method = RequestMethod.GET)
	public ModelAndView searchList(@RequestParam("word") String word, @RequestParam("start") String start) {
		int startnum = Integer.parseInt(start);
		if (startnum>1000) {
			startnum = 1000;
		}
		ShoppingCondition sc = new ShoppingCondition(word,5,startnum,"sim");
		ArrayList<JSONObject> list = biz.searchList(sc);
		ModelAndView mav = new ModelAndView("product/product_listing", "list", list);
		mav.addObject("word", word);
		startnum = startnum+5;
		mav.addObject("start", startnum);
		return mav;
	}
	
	
	@RequestMapping(value = "/redirectURL.do")
	@ResponseBody
	public String redirectURL(@RequestParam("url") String url, HttpServletRequest request) {
		return url;
	}

}