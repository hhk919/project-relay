package relay.controller.relay;

import java.util.HashMap;
import java.util.List;

import org.bson.BasicBSONObject;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import relay.biz.relay.RelayBIZ;
import relay.vo.relay.RelayVO;

@RestController
public class RelayController {
	
	@Autowired
	private RelayBIZ ryBiz;
	
	@RequestMapping("/relay/create.do")
	public boolean create(@RequestBody String relayvo) {
		JSONObject jsonobject = (JSONObject)JSONValue.parse(relayvo);
		boolean result = ryBiz.create(jsonobject);
		return result;
	}
	
	
	@RequestMapping("/relay/detail.do")
	public RelayVO getRelay(@RequestParam("listId") String listId){
		RelayVO list = ryBiz.getDetail(listId);
		return list;
	}
	
	@RequestMapping("/relay/getDetail.do")
	public ModelAndView getRelayList(@RequestParam("listId") String listId){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("relay/relay");
		mav.addObject("listId", listId);
		return mav;
	}
	
	@RequestMapping("/relay/getInfo.do")
	public List<BasicBSONObject> getInfo(@RequestParam("id") String memberId) {
		List<BasicBSONObject> result = ryBiz.getInfo(memberId);
		return result;
	}
	
	@PutMapping(value = "/relay/delete.do", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> deleteSender(@RequestParam("listId")String listId, @RequestParam("id")String memberId) {
		int result = ryBiz.deleteSender(listId, memberId);
		return result == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping("/relay/updateGift.do")
	public ResponseEntity<String> updateGift(@RequestBody HashMap<String, String> data) {
		int updateCount = 0;
		int result = ryBiz.updateGift(data);
		if (result > 0) {
			updateCount = 1;
		}
		return updateCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	


}
