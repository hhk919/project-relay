package relay.controller.reply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import relay.biz.reply.ReplyBIZ;
import relay.common.Criteria;
import relay.vo.reply.ReplyVO;

@RestController
public class ReplyController {

	@Autowired
	private ReplyBIZ rBiz;
	
	@PostMapping(value = "/replyInsert.do", consumes = "application/json", 
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> insertReply(@RequestBody ReplyVO vo){
		int insertCount = rBiz.insertReply(vo);
		
		return insertCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping("/replyList.do")
	public List<ReplyVO> getList(@RequestParam String bno, 
			@RequestParam(defaultValue = "1") int page){
		Criteria cri = new Criteria(page, 10);
		List<ReplyVO> list = rBiz.getList(cri, bno);	
		return list;
	}
	
	@PutMapping(value = "/replyUpdate.do", consumes = "application/json", produces = {
					MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> updateReply(@RequestBody ReplyVO vo, 
			@RequestParam ("cno") String cno){
		vo.setCno(cno);
		return rBiz.updateReply(vo) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PutMapping(value = "/replyDelete.do", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> deleteReply(@RequestParam ("cno") String cno) {
		return rBiz.deleteReply(cno) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/{cno}", 
			produces = { MediaType.APPLICATION_XML_VALUE, 
				     MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<ReplyVO> getReply(@PathVariable("cno") String cno){
		
		return new ResponseEntity<>(rBiz.getReply(cno), HttpStatus.OK);
	}
	
}
