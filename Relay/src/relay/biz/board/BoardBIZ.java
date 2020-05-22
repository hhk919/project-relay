package relay.biz.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import relay.dao.board.BoardDAO;
import relay.vo.board.BoardVO;
import relay.common.Criteria;

@Service
public class BoardBIZ {
	@Autowired
	BoardDAO dao;
	
	public List<BoardVO> getList(Criteria cri){
		return dao.getList(cri);
	}
	
	public List<BoardVO> getListForAdmin() {
		return dao.getListForAdmin();
	}
	
	public int getTotal(Criteria cri) {
		return dao.getTotalCount(cri);
	}
	
	public BoardVO getPost(String bno) {
		return dao.getPost(bno);
	}
	
	public String insertPost(BoardVO vo) {
		return dao.insertPost(vo);
	}
	
	public String insertPostWithImg(BoardVO vo) {
		return dao.insertPostWithImg(vo);
	}
	
	public int deletePost(String bno){
		return dao.deletePost(bno);
	}
	
	public int updatePost(BoardVO vo) {
		return dao.updatePost(vo);
	}
	
	public int updatePostWithImg(BoardVO vo) {
		return dao.updatePostWithImg(vo);
	}
	
	public BoardVO getPostForUpdate(String bno) {
		return dao.getPost(bno);
	}

	public int increaseCount(String bno) {
		return dao.increaseCount(bno);
	}

	public int updateReplyCNT(int bno) {
		return dao.updateReplyCNT(bno);
	}
	
}
