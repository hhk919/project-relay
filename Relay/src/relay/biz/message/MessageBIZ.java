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

	public List<MessageVO> getList(String mno) {
		return dao.getList(mno);
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
	
	public int insertMessageForInvited(MessageVO vo) {
		return dao.insertMessageForInvited(vo);
	}

	public int deleteMessage(int sno) {
		return dao.deleteMessage(sno);
	}

	public int getMessage(int sno, String mno2) {
		return dao.getMessage(sno, mno2);
	}

	public int updateRestate(int sno, int mno2, int restate) {
		return dao.updateRestate(sno, mno2, restate);
	}
	
}
