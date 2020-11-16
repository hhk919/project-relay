package relay.mapper.notice;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import relay.common.Criteria;
import relay.vo.notice.NoticeVO;

public interface NoticeMapper {

	@Select("SELECT n.nno, n.ntitle, n.n m.nick FROM relay.notice n USE INDEX (primary) LEFT JOIN relay.member m USING (mno) WHERE nvis = 1 ORDER BY nno DESC")
	public List<NoticeVO> getList();
	
	@Update("UPDATE relay.notice SET ncnt = ncnt+1 WHERE nno = #{nno}")
	public int increaseCount(String nno);
	
	@Select("SELECT n.nno, n.ntitle, m.nick, n.ncnt FROM relay.notice n USE INDEX (primary) LEFT JOIN relay.member m USING (mno) WHERE nvis = 1 ORDER BY nno DESC limit 5")
	public List<NoticeVO> getListForBoard();
	
	@Select("SELECT n.nno, n.ntitle, m.nick, n.ncontent, n.ncnt FROM relay.notice n USE INDEX (primary) LEFT JOIN relay.member m USING (mno) WHERE nvis = 1 ORDER BY nno DESC limit 3")
	public List<NoticeVO> getListForMain();
	
	@Select("SELECT n.nno, n.ntitle, m.nick, n.ncnt FROM relay.notice n USE INDEX (primary) LEFT JOIN relay.member m USING (mno) ORDER BY nno DESC")
	public List<NoticeVO> getListForAdmin();
	
	@Select("SELECT n.*, m.nick FROM relay.notice n USE INDEX (primary) LEFT JOIN relay.member m USING (mno) WHERE nno = #{nno} ORDER BY nno DESC")
	public NoticeVO getPost(String nno);
	
	@Insert("INSERT INTO relay.notice(ntitle, ncontent, mno) VALUES (#{ntitle}, #{ncontent}, #{mno})")
	public int insertPost(NoticeVO vo);

	@Update("UPDATE relay.notice SET nvis = 0 WHERE nno = #{nno}")
	public int deletePost(String nno);
	
	@Update("UPDATE relay.notice SET ntitle = #{ntitle}, nupdate = now(), ncontent = #{ncontent} WHERE nno = #{nno}")
	public int updatePost(NoticeVO vo);

	@Select({"<script>",
			"SELECT A.* FROM (",
			"(SELECT @ROWNUM:=@ROWNUM+1 as rn, N.* ",
			"FROM RELAY.NOTICE N USE INDEX (primary) LEFT JOIN RELAY.MEMBER M ",
			"USING (MNO) ",
			"WHERE nvis = 1 ORDER BY NNO DESC) A, ",
			"(SELECT @ROWNUM:=0) Z)",
			"WHERE rn > (#{pageNum}-1)*#{amount}",
				"<trim prefix=\" AND (\" suffix=\")\" prefixOverrides=\"OR\">",
					"<foreach item='type' collection=\"typeArr\">",
						"<trim prefix=\" OR\">",
							"<choose>",
								"<when test=\"type == 'T'.toString()\">",
									" AND ntitle LIKE CONCAT('%',#{keyword},'%')",
								"</when>",
								"<when test=\"type == 'C'.toString()\">",
									" AND ncontent LIKE CONCAT('%',#{keyword},'%')",
								"</when>",
								"<when test=\"type == 'W'.toString()\">",
									" AND UPPER(nick) LIKE UPPER(CONCAT('%',#{keyword},'%'))",
								"</when>",
							"</choose>",
						"</trim>",
					"</foreach>",
				"</trim>",
			"LIMIT #{amount}",
			"</script>"})
	public List<NoticeVO> searchWithPaging(Criteria cri);
	
	@Select("<script>"
				+ "SELECT count(1) FROM RELAY.notice N LEFT JOIN RELAY.member M USING (mno) WHERE nvis = 1 AND "
				+ "<trim prefix=\" AND (\" suffix=\")\" prefixOverrides=\"OR\">"
					+ "<foreach item='type' collection=\"typeArr\">"
						+ "<trim prefix=\"OR\">"
							+ "<choose>"
								+ "<when test=\"type == 'T'.toString()\">"
									+ "ntitle LIKE CONCAT('%',#{keyword},'%')"
								+ "</when>"
								+ "<when test=\"type == 'C'.toString()\">"
									+ "ncontent LIKE CONCAT('%',#{keyword},'%')"
								+ "</when>"
								+ "<when test=\"type == 'W'.toString()\">"
									+ "UPPER(nick) LIKE UPPER(CONCAT('%',#{keyword},'%'))"
								+ "</when>"
							+ "</choose>"
						+ "</trim>"
					+ "</foreach>"
				+ "</trim>"
			+ "</script>")
	public int getTotalCount(Criteria cri);
	
}
