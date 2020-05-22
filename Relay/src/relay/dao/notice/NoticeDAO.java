package relay.dao.notice;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import relay.mapper.notice.NoticeMapper;
import relay.common.Criteria;
import relay.vo.notice.NoticeVO;

@Repository
public class NoticeDAO {
	@Autowired
	private SqlSessionFactory factory;
	
	public List<NoticeVO> getList(Criteria cri) {
		List<NoticeVO> list = null;
		try {
			NoticeMapper mapper = factory.openSession().getMapper(NoticeMapper.class);
			list = mapper.searchWithPaging(cri);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<NoticeVO> getListForBoard() {
		List<NoticeVO> list = null;
		try {
			NoticeMapper mapper = factory.openSession().getMapper(NoticeMapper.class);
			list = mapper.getListForBoard();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<NoticeVO> getListForAdmin() {
		List<NoticeVO> list = null;
		try {
			NoticeMapper mapper = factory.openSession().getMapper(NoticeMapper.class);
			list = mapper.getListForAdmin();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<NoticeVO> getListForMain() {
		List<NoticeVO> list = null;
		try {
			NoticeMapper mapper = factory.openSession().getMapper(NoticeMapper.class);
			list = mapper.getListForMain();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public NoticeVO getPost(String nno) {
		NoticeVO vo = null;
		try {
			NoticeMapper mapper = factory.openSession().getMapper(NoticeMapper.class);
			vo = mapper.getPost(nno);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	public String insertPost(NoticeVO vo) {
		String result = null;
		try {
			NoticeMapper mapper = factory.openSession().getMapper(NoticeMapper.class);
			int n = mapper.insertPost(vo);
			if (n > 0) {
				result = vo.getMno();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int deletePost(String nno) {
		int a = 0;
		try {
			NoticeMapper mapper = factory.openSession().getMapper(NoticeMapper.class);
			a = mapper.deletePost(nno);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return a;
	}
	
	public int updatePost(NoticeVO vo) {
		int r = 0;
		try {
			NoticeMapper mapper = factory.openSession().getMapper(NoticeMapper.class);
			r = mapper.updatePost(vo);
			if (r > 0) {
				factory.openSession().commit();
			} else {
				factory.openSession().rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return r;
	}

	public int getTotalCount(Criteria cri) {
		int r = 0;
		try {
			NoticeMapper mapper = factory.openSession().getMapper(NoticeMapper.class);
			r = mapper.getTotalCount(cri);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return r;
	}

	public int increaseCount(String nno) {
		int result = 0;
		try {
			NoticeMapper mapper = factory.openSession().getMapper(NoticeMapper.class);
			result = mapper.increaseCount(nno);
			if (result > 0) {
				factory.openSession().commit();
			} else {
				factory.openSession().rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
