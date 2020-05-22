package relay.dao.message;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import relay.mapper.message.MessageMapper;
import relay.vo.message.MessageVO;

@Repository
public class MessageDAO {
	
	@Autowired
	private SqlSessionFactory factory;

	public List<MessageVO> getList(String mno) {
		List<MessageVO> list = null;
		try {
			MessageMapper mapper = factory.openSession().getMapper(MessageMapper.class);
			list = mapper.getList(mno);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<MessageVO> getSentList(String mno) {
		List<MessageVO> list = null;
		try {
			MessageMapper mapper = factory.openSession().getMapper(MessageMapper.class);
			list = mapper.getSentList(mno);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getUnreadCount(String mno) {
		int cnt = 0;
		try {
			MessageMapper mapper = factory.openSession().getMapper(MessageMapper.class);
			cnt = mapper.getUnreadCount(mno);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return cnt;
	}

	public int insertMessage(MessageVO vo) {
		int result = 0;
		try {
			MessageMapper mapper = factory.openSession().getMapper(MessageMapper.class);
			result = mapper.insertMessage(vo);
			if(result > 0) {
				factory.openSession().commit();
			}else {
				factory.openSession().rollback();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int insertMessageForInvited(MessageVO vo) {
		int result = 0;
		try {
			MessageMapper mapper = factory.openSession().getMapper(MessageMapper.class);
			result = mapper.insertMessageForInvited(vo);
			if(result > 0) {
				factory.openSession().commit();
			}else {
				factory.openSession().rollback();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int deleteMessage(int sno) {
		int result = 0;
		try {
			MessageMapper mapper = factory.openSession().getMapper(MessageMapper.class);
			result = mapper.deleteMessage(sno);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int getMessage(int sno, String mno2) {
		int result = 0;
		try {
			MessageMapper mapper = factory.openSession().getMapper(MessageMapper.class);
			result = mapper.getMessage(sno, mno2);
			if(result > 0) {
				factory.openSession().commit();
			}else {
				factory.openSession().rollback();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int updateRestate(int sno, int mno2, int restate) {
		int result = 0;
		try {
			MessageMapper mapper = factory.openSession().getMapper(MessageMapper.class);
			result = mapper.updateRestate(sno, mno2, restate);
			if(result > 0) {
				factory.openSession().commit();
			}else {
				factory.openSession().rollback();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
}
