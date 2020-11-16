package relay.controller.wishlist;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.bson.BasicBSONObject;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import relay.biz.wishlist.WishlistBIZ;
import relay.vo.member.MemberVO;
import relay.vo.product.ProductVO;

@RestController
public class WishlistController {
	
	@Autowired
	private WishlistBIZ wBiz;
	
	@RequestMapping("/wishlist.do")
	public ModelAndView getList(@RequestParam("id") String memberId) {
		List<ProductVO> list = wBiz.getList(memberId);
		ModelAndView mav = new ModelAndView();
		mav.addObject("wishlist", list);
		mav.setViewName("wishlist/list");
		return mav;
	}
	
	@RequestMapping("/wishlist/getMostWishedList.do")
	public List<BasicBSONObject> getMostWishedList() {
		List<BasicBSONObject> list = wBiz.getMostWishedList();
		return list;
	}
	
	@RequestMapping("/wishlist/list.do")
	public List<ProductVO> getListDetail(@RequestParam("id") String memberId) {
		List<ProductVO> list = wBiz.getList(memberId);
		return list;
	}
	
	@RequestMapping("/wishlist/cnt.do")
	public long getTotal(@RequestParam("id") String memberId) {
		long cnt = wBiz.getTotal(memberId);
		return cnt;
	}
	
	@PostMapping(value = "/wishlist/insert.do", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> insertWishlist(@RequestBody JSONObject data, HttpServletRequest request){
		MemberVO member = (MemberVO) request.getSession().getAttribute("vo1");
		int result = wBiz.insertWishlist(data,member);
		return result == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PutMapping(value = "/wishlist/delete.do", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> deleteWishlist(@RequestParam("pid") long pid, @RequestParam("id") String memberId) {
		int result = wBiz.deleteWishlist(pid, memberId);
		return result == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PutMapping(value = "/wishlist/updateGrade.do", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> updateGrade(@RequestParam("pid") long pid, @RequestParam("id") String memberId, @RequestParam("grade") int grade) {
		int result = wBiz.updateGrade(pid, memberId, grade);
		return result == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
