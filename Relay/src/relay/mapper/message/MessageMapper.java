package relay.mapper.message;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import relay.vo.message.MessageVO;

public interface MessageMapper {

	@Select("SELECT m.sno, m.mno1, m.mno2, m.stitle, m.scontent, m.sstate, m.sdate, m.restate, m.rno, a.name, a.nick " + 
			"FROM message m JOIN member a ON m.mno1 = a.mno " + 
			"WHERE m.mno2 = #{mno} AND svis = 1 ORDER BY sno DESC")
	public List<MessageVO> getList(String mno);
	
	@Select("SELECT m.sno, m.mno1, m.mno2, m.stitle, m.scontent, m.sstate, m.sdate, m.restate, a.name, a.nick " + 
			"FROM message m JOIN member a ON m.mno2 = a.mno " + 
			"WHERE m.mno1 = #{mno} AND svis = 1 ORDER BY sno DESC")
	public List<MessageVO> getSentList(String mno);
	
	@Select("SELECT COUNT(*) FROM message WHERE sstate = 1 AND mno2 = #{mno}")
	public int getUnreadCount(String mno);
	
	@Insert("INSERT INTO message VALUES(sno.nextval, #{mno1}, #{mno2}, #{stitle}, #{scontent}, #{sstate}, default, default, #{restate}, (SELECT MAX(rno) FROM relay))")
	public int insertMessage(MessageVO vo);
	
	@Insert("INSERT INTO message VALUES(sno.nextval, #{mno1}, #{mno2}, #{stitle}, #{scontent}, #{sstate}, default, default, #{restate}, #{rno})")
	public int insertMessageForInvited(MessageVO vo);
	
	@Update("UPDATE message SET svis = 0 WHERE sno = #{sno}")
	public int deleteMessage(int sno);

	@Update("UPDATE message SET sstate = 2 WHERE sno = #{sno} AND mno2 = #{mno2}")
	public int getMessage(@Param("sno") int sno, @Param("mno2") String mno2);

	@Update("UPDATE message SET restate = #{restate} WHERE sno = #{sno} AND mno2 = #{mno2}")
	public int updateRestate(@Param("sno") int sno, @Param("mno2") int mno2, @Param("restate") int restate);
	
}
