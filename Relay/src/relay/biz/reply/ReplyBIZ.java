package relay.biz.reply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import relay.common.Criteria;
import relay.common.ReplyPageDTO;
import relay.dao.reply.ReplyDAO;
import relay.vo.reply.ReplyVO;

@Service
public class ReplyBIZ {
	
	@Autowired
	private ReplyDAO dao;
	
	public List<ReplyVO> getList(Criteria cri, String bno){
		return dao.getList(cri, bno);
	}
	
	public ReplyPageDTO getListWithPaging(Criteria cri, String bno){
		return dao.replyPageDTO(cri, bno);
	}
	
	public ReplyVO getReply(String cno) {
		return dao.getReply(cno);
	}
	
	public int insertReply(ReplyVO vo) {
		return dao.insertReply(vo);
	}
	
	public int deleteReply(String rno){
		return dao.deleteReply(rno);
	}
	
	public int updateReply(ReplyVO vo) {
		return dao.updateReply(vo);
	}
		
}