package relay.mapper.reply;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import relay.common.Criteria;
import relay.vo.reply.ReplyVO;

public interface ReplyMapper {
	
	@Insert("INSERT INTO relay.comm (bno, mno, ccontent, creplyer) VALUES (#{bno}, #{mno}, #{ccontent}, #{creplyer})")
	public int insertReply(ReplyVO vo);
	
	@Select("SELECT cno, bno, ccontent, creplyer, cdate, cupdate FROM relay.comm WHERE bno = #{bno} ORDER BY cno")
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") String bno);
	
	@Select("<script>" +
			"<![CDATA[ SELECT cno, bno, ccontent, creplyer, cdate, cupdate " + 
			"FROM" +
			"( " +
			"SELECT /*+ INDEX(comm pk_com) */ " + 
			"rownum rn, bno, cno, ccontent, creplyer, cdate, cupdate FROM comm " + 
			"WHERE bno = #{bno} AND cno > 0 AND rownum <= #{cri.pageNum} * #{cri.amount}) " + 
			"WHERE rn > 1 ]]>" +
			"</script>")
	public List<ReplyVO> getListWithPaging2(@Param("cri") Criteria cri, @Param("bno") String bno);
	
	@Select("<script>" +
			"<![CDATA[ " +
			"SELECT COUNT(cno) FROM comm WHERE bno = #{bno} AND cvis = 1" +
			"]]>" +
			"</script>"
			)
	public int getTotalCountByBno(String bno);
	
	@Update("UPDATE relay.comm SET ccontent = #{ccontent}, cupdate = now() WHERE cno = #{cno}")
	public int updateReply(ReplyVO vo);
	
	@Update("UPDATE relay.comm SET ccontent = '삭제된 댓글입니다.',cupdate = now() WHERE cno = #{cno}")
	public int deleteReply(String cno);
	
	@Select("SELECT * FROM comm WHERE cno = #{cno}")
	public ReplyVO getReply(String cno);
	
}
