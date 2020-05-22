package relay.dao.reply;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import relay.common.Criteria;
import relay.common.ReplyPageDTO;
import relay.mapper.reply.ReplyMapper;
import relay.vo.reply.ReplyVO;

@Repository
public class ReplyDAO {
	@Autowired
	private SqlSessionFactory factory;

	public List<ReplyVO> getList(Criteria cri, String bno) {
		List<ReplyVO> list = null;
		try {
			ReplyMapper mapper = factory.openSession().getMapper(ReplyMapper.class);
			list = mapper.getListWithPaging(cri, bno);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<ReplyVO> getListWithPaging(Criteria cri, String bno) {
		List<ReplyVO> list = null;
		try {
			ReplyMapper mapper = factory.openSession().getMapper(ReplyMapper.class);
			list = mapper.getListWithPaging2(cri, bno);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ReplyPageDTO replyPageDTO(Criteria cri, String bno) {
		List<ReplyVO> list = null;
		int replycnt = 0;
		int res = 0;
		ReplyPageDTO rpdto = new ReplyPageDTO(replycnt, list);
		try {
			ReplyMapper mapper = factory.openSession().getMapper(ReplyMapper.class);
			res = mapper.getTotalCountByBno(bno);
			list = mapper.getListWithPaging2(cri, bno);
			rpdto.setList(list);
			rpdto.setReplycnt(res);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return rpdto;
	}
	
	public int getTotalCountByBno(String bno) {
		int res = 0;
		try {
			ReplyMapper mapper = factory.openSession().getMapper(ReplyMapper.class);
			res = mapper.getTotalCountByBno(bno);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	public ReplyVO getReply(String cno) {
		ReplyVO vo = null;
		try {
			ReplyMapper mapper = factory.openSession().getMapper(ReplyMapper.class);
			vo = mapper.getReply(cno);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

	public int insertReply(ReplyVO vo) {
		int res = 0;
		try {
			ReplyMapper mapper = factory.openSession().getMapper(ReplyMapper.class);
			res = mapper.insertReply(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	public int deleteReply(String cno) {
		int res = 0;
		try {
			ReplyMapper mapper = factory.openSession().getMapper(ReplyMapper.class);
			res = mapper.deleteReply(cno);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	public int updateReply(ReplyVO vo) {
		int res = 0;
		try {
			ReplyMapper mapper = factory.openSession().getMapper(ReplyMapper.class);
			res = mapper.updateReply(vo);
			if(res > 0) {
				factory.openSession().commit();
			}else {
				factory.openSession().rollback();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	
}
