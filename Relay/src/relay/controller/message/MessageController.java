package relay.controller.message;

import java.util.List;

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

import relay.biz.member.MemberBIZ;
import relay.biz.message.MessageBIZ;
import relay.vo.message.MessageVO;

@RestController
public class MessageController {
	
	@Autowired
	private MessageBIZ mBiz;
	
	@Autowired
	private MemberBIZ mbBiz;
	
	@RequestMapping("/message/list.do")
	public List<MessageVO> getList(@RequestParam String receiver){
		List<MessageVO> list = mBiz.getList(receiver);
		return list;
	}
	
	@RequestMapping("/message/sent.do")
	public List<MessageVO> getSentList(@RequestParam String mno){
		List<MessageVO> list = mBiz.getSentList(mno);
		return list;
	}
	
	@RequestMapping("/message/getUnreadCount.do")
	public int getUnreadCount(@RequestParam String mno){
		int cnt = mBiz.getUnreadCount(mno);
		return cnt;
	}
	
	@PostMapping(value="/message/insert.do", consumes="application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> insertMessage(@RequestBody MessageVO vo){
		int insertCount = mBiz.insertMessage(vo);
		return insertCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PutMapping(value = "/message/delete.do", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> deleteMessage(@RequestParam("svis") int svis, @RequestParam("sno") int sno){
		return mBiz.deleteMessage(svis, sno) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PutMapping(value = "/message/getMessage.do", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> getMessage(@RequestParam ("sno") int sno){
		return mBiz.getMessage(sno) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
//	@PutMapping(value = "/message/updateRestate.do", produces = { MediaType.TEXT_PLAIN_VALUE })
//	public ResponseEntity<String> updateRestate(@RequestParam ("sno") int sno, @RequestParam ("mno2") int mno2, @RequestParam ("rno") int rno, @RequestParam ("restate") int restate){
//		int updateResult = 0;
//		if(restate == 3) {
//			//릴레이 수락
//			rBiz.insertRdetailForInvited(mno2, rno);
//		}
//		updateResult = mBiz.updateRestate(sno, mno2, restate);
//		
//		return updateResult == 1
//				? new ResponseEntity<>("success", HttpStatus.OK)
//						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//	}
}
