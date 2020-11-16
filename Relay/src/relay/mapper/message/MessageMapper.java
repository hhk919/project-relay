package relay.mapper.message;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import relay.vo.message.MessageVO;

public interface MessageMapper {

	@Select("SELECT * " + 
			"FROM relay.message m USE INDEX (PRIMARY) " + 
			"WHERE m.receiver = #{receiver} AND svis IN (1,2) ORDER BY sno DESC")
	public List<MessageVO> getList(String receiver);
	
	@Select("SELECT * " + 
			"FROM relay.message m USE INDEX (PRIMARY) " + 
			"WHERE m.sender = #{sender} AND svis IN (1,3) ORDER BY sno DESC")
	public List<MessageVO> getSentList(String sender);
	
	@Select("SELECT COUNT(*) FROM relay.message WHERE sstate = 1 AND receiver = #{mno}")
	public int getUnreadCount(String mno);
	
	@Insert("INSERT INTO relay.message (sender, snick, receiver, rnick, stitle, scontent) VALUES (#{sender}, (select nick from relay.member where mno = #{sender}), #{receiver}, (select nick from relay.member where mno = #{receiver}), #{stitle}, #{scontent})")
	public int insertMessage(MessageVO vo);
	
//	@Insert("INSERT INTO message VALUES(#{mno1}, #{mno2}, #{stitle}, #{scontent}, #{sstate}, default, default, #{restate})")
//	public int insertMessageForInvited(MessageVO vo);
	
	@Update("UPDATE relay.message SET svis = CASE WHEN svis = 2 THEN 0 WHEN svis = 3 THEN 0 ELSE #{svis} END WHERE sno = #{sno}")
	public int deleteMessage(@Param("svis")int svis, @Param("sno")int sno);

	@Update("UPDATE relay.message SET sstate = 0 WHERE sno = #{sno}")
	public int getMessage(int sno);

//	@Update("UPDATE message SET restate = #{restate} WHERE sno = #{sno} AND mno2 = #{mno2}")
//	public int updateRestate(@Param("sno") int sno, @Param("mno2") int mno2, @Param("restate") int restate);
	
}
