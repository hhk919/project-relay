package relay.dao.board;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import relay.mapper.board.BoardMapper;
import relay.vo.board.BoardVO;
import relay.common.Criteria;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSessionFactory factory;
	
	public String insertPost(BoardVO vo) {
		String result = null;
		try {
			BoardMapper mapper = factory.openSession().getMapper(BoardMapper.class);
			int n = mapper.insertPost(vo);
			if (n > 0) {
				result = vo.getMno();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public String insertPostWithImg(BoardVO vo) {
		String result = null;
		try {
			BoardMapper mapper = factory.openSession().getMapper(BoardMapper.class);
			int n = mapper.insertPostWithImg(vo);
			if (n > 0) {
				result = vo.getMno();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public List<BoardVO> getList(Criteria cri) {
		List<BoardVO> list = null;
		try {
			BoardMapper mapper = factory.openSession().getMapper(BoardMapper.class);
			list = mapper.searchWithPaging(cri);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<BoardVO> getListForAdmin() {
		List<BoardVO> list = null;
		try {
			BoardMapper mapper = factory.openSession().getMapper(BoardMapper.class);
			list = mapper.getListForAdmin();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int deletePost(String bno) {
		int result = 0;
		try {
			BoardMapper mapper = factory.openSession().getMapper(BoardMapper.class);
			result = mapper.deletePost(bno);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public BoardVO getPost(String bno) {
		BoardVO vo = null;
		try {
			BoardMapper mapper = factory.openSession().getMapper(BoardMapper.class);
			vo = mapper.getPost(bno);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}

	public int updatePost(BoardVO vo) {
		int result = 0;
		try {
			BoardMapper mapper = factory.openSession().getMapper(BoardMapper.class);
			result = mapper.updatePost(vo);
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
	
	public int updatePostWithImg(BoardVO vo) {
		int result = 0;
		try {
			BoardMapper mapper = factory.openSession().getMapper(BoardMapper.class);
			result = mapper.updatePostWithImg(vo);
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

	public int getTotalCount(Criteria cri) {
		int result = 0;
		try {
			BoardMapper mapper = factory.openSession().getMapper(BoardMapper.class);
			result = mapper.getTotal(cri);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int increaseCount(String bno) {
		int result = 0;
		try {
			BoardMapper mapper = factory.openSession().getMapper(BoardMapper.class);
			result = mapper.increaseCount(bno);
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

	public int updateReplyCNT(int bno) {
		int result = 0;
		try {
			BoardMapper mapper = factory.openSession().getMapper(BoardMapper.class);
			result = mapper.updateReplyCNT(bno);
			if(result > 0) {
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
