package relay.mapper.relay;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import relay.vo.message.MessageVO;
import relay.vo.relay.RelayVO;

public interface RelayMapper {
	
	@Select("SELECT a.rno, a.rname, a.rage FROM RELAY A JOIN RDETAIL B  on A.RNO = B.RNO WHERE B.MNO = #{mno}")
	List<RelayVO> getRname(int mno);
	
	@Select("SELECT m.mno, m.id, m.pw, m.name, m.nick, m.birth, m.addr, d.gender, d.age, d.job, d.hobby, p.pno, p.pname, p.pmall, p.pmallurl, p.catid, p.pimg , r.rname, r.rage, r.rgender, r.rjob, r.rhobby " +
			"FROM rdetail rd LEFT JOIN member m ON rd.mno = m.mno LEFT JOIN detail d ON rd.mno = d.mno LEFT JOIN product p ON rd.pno = p.pno LEFT JOIN relay r on rd.rno = r.rno " +
			"WHERE rd.rno = #{rno}")
	List<RelayVO> getRelay(int rno);
	
	@Select("SELECT * FROM relay WHERE rno = #{rno}")
	List<RelayVO> getList(int rno);
	
	@Insert("INSERT INTO relay VALUES (RNO.NEXTVAL, #{mno1}, #{rname}, #{rage}, #{rgender}, #{rjob}, #{rhobby})")
	int insertRelay(MessageVO vo);

	@Insert("INSERT INTO rdetail VALUES ((SELECT MAX(rno) FROM RELAY), #{mno1}, default)")
	int insertRdetail(MessageVO vo);
	
	@Insert("INSERT INTO rdetail VALUES(#{rno}, #{mno2}, default)")
	int insertRdetailForInvited(@Param("mno2") int mno2, @Param("rno") int rno);
	
	@Update("UPDATE rdetail SET pno = #{pno} WHERE rno = #{rno} AND mno = #{mno}")
	public int updateRelayProduct(@Param("rno") int rno, @Param("pno") long pno, @Param("mno") int mno);

	@Delete("DELETE FROM rdetail WHERE rno = #{rno} AND mno = #{mno}")
	int outRelay(@Param("rno") int rno, @Param("mno") int mno);

}
