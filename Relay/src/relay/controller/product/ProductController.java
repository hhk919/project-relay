package relay.controller.product;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
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
	
	@RequestMapping(value = "/prdinsertAdmin.do", method = RequestMethod.POST)
	public ModelAndView insertProductForAdmin(@ModelAttribute ShoppingCondition sc) {
		int r = biz.insertProductForAdmin(sc);
		ModelAndView mav = new ModelAndView("admin/productMinserted", "inserted", r);
		return mav;
	}

	@RequestMapping(value = "/prdinsertoneAdmin.do", method = RequestMethod.POST)
	public ModelAndView insertProductForAdmin(ProductVO prd) {
		int r = biz.insertProductForAdmin(prd);
		ModelAndView mav = new ModelAndView("admin/productMinserted", "inserted", r);
		return mav;
	}

	@RequestMapping(value = "/updateAdmin.do", method = RequestMethod.POST)
	public ModelAndView updateProductForAdmin(ProductVO prd, HttpServletRequest request) {
		String s = request.getParameter("go");
		int res = biz.updateProductForAdmin(prd);
		if (res == 1) {
			ModelAndView mav = new ModelAndView("admin/productMupdated", "updated", prd);
			mav.addObject("go", s);
			return mav;
		}
		return null;
	}

	@RequestMapping("/prdlistAdmin.do")
	public ModelAndView getListForAdmin(HttpServletRequest request) {
		List<ProductVO> list = biz.getListForAdmin();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/productMlist");
		mav.addObject("list", list);
		return mav;

	}

	@RequestMapping(value = "/prdsearchAdmin.do", method = RequestMethod.GET)
	public ModelAndView searhProductForAdmin(@RequestParam("go") String pname, HttpServletRequest request) {
		String s = request.getParameter("go");
		if (s == "") {
			ModelAndView mav = new ModelAndView();
			mav.setView(new RedirectView("/Relay/prdlistAdmin.do"));
			return mav;
		}
		String name = "%" + pname + "%";
		List<ProductVO> r = biz.searchListForAdmin(name);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/productMsearched");
		mav.addObject("searchlist", r);
		mav.addObject("go", pname);
		return mav;
	}

	@RequestMapping(value = "/prdsearchoneAdmin.do", method = RequestMethod.GET)
	public ModelAndView searchProductForAdmin(@RequestParam("update_no") int update_no, HttpServletRequest request) {
		String s = request.getParameter("go");
		ProductVO r = biz.searchProductForAdmin(update_no);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/productMview");
		mav.addObject("searchone", r);
		mav.addObject("go", s);
		return mav;
	}

	@RequestMapping(value = "/prddeleteAdmin.do")
	public ModelAndView deleteProdctForAdmin(@RequestParam("delete_no") int delete_no, HttpServletRequest request) {
		String s = request.getParameter("go");
		biz.deleteProductForAdmin(delete_no);
		ModelAndView mav = new ModelAndView("admin/productMdeleted", "deleted", delete_no);
		mav.addObject("go", s);
		return mav;
	}
	
	@RequestMapping(value = "/redirectURL.do")
	@ResponseBody
	public String redirectURL(@RequestParam("url") String url, HttpServletRequest request) {
		return url;
	}

}