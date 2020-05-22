package relay.controller.recommend;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import relay.biz.recommend.RecommendBIZ;
import relay.vo.recommend.RecommendVO;

@RestController
public class RecommendController {

	@Autowired
	private RecommendBIZ rcBiz;
	
	@RequestMapping("/recommend/getRecommendListByWishlist.do")
	public List<RecommendVO> getRecommendListByWishlist(@RequestParam ("mno") int mno){
		List<RecommendVO> list = null;
		list = rcBiz.getRecommendListByWishlist(mno);
		return list;
	}
	
	@RequestMapping("/recommend/getRecommendListByAge.do")
	public List<RecommendVO> getRecommendListByAge(@RequestParam ("age") int age){
		List<RecommendVO> list = null;
		list = rcBiz.getRecommendListByAge(age);
		return list;
	}
	
	@RequestMapping("/recommend/getRecommendListByGender.do")
	public List<RecommendVO> getRecommendListByGender(@RequestParam ("gender") String gender){
		List<RecommendVO> list = null;
		list = rcBiz.getRecommendListByGender(gender);
		return list;
	}
	
	@RequestMapping("/recommend/getRecommendListByHobby.do")
	public List<RecommendVO> getRecommendListByHobby(@RequestParam ("hobby") String hobby){
		List<RecommendVO> list = null;
		list = rcBiz.getRecommendListByHobby(hobby);
		return list;
	}
	
	@RequestMapping("/recommend/getRecommendListByAgeGenderHobby.do")
	public List<RecommendVO> getRecommendListByAgeGenderHobby(@RequestParam ("age") int age, @RequestParam ("gender") String gender, @RequestParam ("hobby") String hobby){
		List<RecommendVO> list = null;
		list = rcBiz.getRecommendListByAgeGenderHobby(age, gender, hobby);
		return list;
	}
}
