package relay.mapper.reply;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import relay.common.Criteria;
import relay.vo.reply.ReplyVO;

public interface ReplyMapper {
	
	@Insert("INSERT INTO comm (cno, bno, ccontent, creplyer) VALUES (cno.nextval, #{bno}, #{ccontent}, #{creplyer})")
	public int insertReply(ReplyVO vo);
	
	@Select("SELECT cno, bno, ccontent, creplyer, cdate, cupdate FROM comm WHERE bno = #{bno} AND cvis = 1 ORDER BY cno")
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
	
	@Update("UPDATE comm SET ccontent = #{ccontent}, cupdate = sysdate WHERE cno = #{cno}")
	public int updateReply(ReplyVO vo);
	
	@Update("UPDATE comm SET cupdate = sysdate, cvis = 0 WHERE cno = #{cno}")
	public int deleteReply(String cno);
	
	@Select("SELECT * FROM comm WHERE cvis = 1 AND cno = #{cno}")
	public ReplyVO getReply(String cno);
	
}
