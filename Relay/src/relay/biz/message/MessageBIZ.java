package relay.biz.message;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import relay.dao.message.MessageDAO;
import relay.vo.message.MessageVO;

@Service
public class MessageBIZ {

	@Autowired
	private MessageDAO dao;

	public List<MessageVO> getList(String receiver) {
		return dao.getList(receiver);
	}
	
	public List<MessageVO> getSentList(String mno) {
		return dao.getSentList(mno);
	}
	
	public int getUnreadCount(String mno) {
		return dao.getUnreadCount(mno);
	}

	public int insertMessage(MessageVO vo) {
		return dao.insertMessage(vo);
	}
	
//	public int insertMessageForInvited(MessageVO vo) {
//		return dao.insertMessageForInvited(vo);
//	}

	public int deleteMessage(int svis, int sno) {
		return dao.deleteMessage(svis, sno);
	}

	public int getMessage(int sno) {
		return dao.getMessage(sno);
	}

//	public int updateRestate(int sno, int mno2, int restate) {
//		return dao.updateRestate(sno, mno2, restate);
//	}
	
}
