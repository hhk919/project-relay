package relay.biz.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import relay.dao.notice.NoticeDAO;
import relay.common.Criteria;
import relay.vo.notice.NoticeVO;

@Service
public class NoticeBIZ {
	@Autowired
	private NoticeDAO dao;
	
	public List<NoticeVO> getList(Criteria cri){
		return dao.getList(cri);
	}
	
	public List<NoticeVO> getListForAdmin(){
		return dao.getListForAdmin();
	}
	
	public List<NoticeVO> getListForBoard(){
		return dao.getListForBoard();
	}
	
	public List<NoticeVO> getListForMain(){
		return dao.getListForMain();
	}

	public NoticeVO getPost(String nno) {
		return dao.getPost(nno);
	}
	
	public String insertPost(NoticeVO vo) {
		return dao.insertPost(vo);
	}
	
	public int deletePost(String nno){
		return dao.deletePost(nno);
	}
	
	public int updatePost(NoticeVO vo) {
		return dao.updatePost(vo);
	}

	public NoticeVO getPostForUpdate(String nno) {
		return dao.getPost(nno);
	}

	public int getTotal(Criteria cri) {
		return dao.getTotalCount(cri);
	}

	public int increaseCount(String nno) {
		return dao.increaseCount(nno);
	}
}
