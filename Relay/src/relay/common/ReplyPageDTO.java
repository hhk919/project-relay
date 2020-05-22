package relay.common;

import java.util.List;

import relay.vo.reply.ReplyVO;

public class ReplyPageDTO {
	private int replycnt;
	private List<ReplyVO> list;
	
	public ReplyPageDTO(int replycnt, List<ReplyVO> list) {
		super();
		this.replycnt = replycnt;
		this.list = list;
	}

	public int getReplycnt() {
		return replycnt;
	}
	public void setReplycnt(int replycnt) {
		this.replycnt = replycnt;
	}
	public List<ReplyVO> getList() {
		return list;
	}
	public void setList(List<ReplyVO> list) {
		this.list = list;
	}
	
	
}
