package relay.mapper.notice;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import relay.common.Criteria;
import relay.vo.notice.NoticeVO;

public interface NoticeMapper {

	@Select("SELECT /*+ INDEX_DESC(notice pk_not) */ * FROM notice JOIN member USING (mno) ORDER BY nno DESC")
	public List<NoticeVO> getList();
	
	@Update("UPDATE notice SET ncnt = ncnt+1 WHERE nno = #{nno}")
	public int increaseCount(String nno);
	
	@Select("SELECT * FROM notice JOIN member USING (mno) WHERE rownum < 6 AND nvis = 1 ORDER BY nno DESC")
	public List<NoticeVO> getListForBoard();
	
	@Select("SELECT * FROM notice JOIN member USING (mno) WHERE rownum < 4 ORDER BY nno DESC")
	public List<NoticeVO> getListForMain();
	
	@Select("SELECT /*+ INDEX_DESC(notice pk_not) */ * FROM notice JOIN member USING (mno) ORDER BY nno DESC")
	public List<NoticeVO> getListForAdmin();
	
	@Select("SELECT * FROM notice JOIN member USING (mno) WHERE nno = #{nno}")
	public NoticeVO getPost(String nno);
	
	@Insert("INSERT INTO notice(nno, ntitle, ncontent, mno) VALUES(nno.nextval, #{ntitle}, #{ncontent}, #{mno})")
	public int insertPost(NoticeVO vo);

	@Update("UPDATE notice SET nvis = 0 WHERE nno = #{nno}")
	public int deletePost(String nno);
	
	@Update("UPDATE notice SET ntitle = #{ntitle}, nupdate = sysdate, ncontent = #{ncontent} WHERE nno = #{nno}")
	public int updatePost(NoticeVO vo);
	
	@Select("<script>"
			+ "SELECT rownum rn, nno, ntitle, ncontent, mno, ndate, nupdate, nick, ncnt "
			+ "FROM "
				+ "("
				+ "SELECT /*+ INDEX_DESC(notice pk_not) */ rownum rn, nno, ntitle, ncontent, mno, ndate, nupdate, nick, ncnt "
				+ "FROM "
				+ "notice JOIN member USING (mno) "
				+ "WHERE nvis = 1 AND "
					+ "<trim prefix=\"(\" suffix=\") AND \" prefixOverrides=\"OR\">"
						+ "<foreach item='type' collection=\"typeArr\">"
							+ "<trim prefix=\"OR\">"
								+ "<choose>"
									+ "<when test=\"type == 'T'.toString()\">"
										+ "ntitle LIKE '%'||#{keyword}||'%'"
									+ "</when>"
									+ "<when test=\"type == 'C'.toString()\">"
										+ "ncontent LIKE '%'||#{keyword}||'%'"
									+ "</when>"
									+ "<when test=\"type == 'W'.toString()\">"
										+ "UPPER(nick) LIKE UPPER('%'||#{keyword}||'%')"
									+ "</when>"
								+ "</choose>"
							+ "</trim>"
						+ "</foreach>"
					+ "</trim>"
			+ "rownum <![CDATA[ <= ]]> #{pageNum} * #{amount}"
			+ ") "
			+ "WHERE "
			+ "rn <![CDATA[ > ]]> (#{pageNum} -1) * #{amount}"
			+ "</script>")
	public List<NoticeVO> searchWithPaging(Criteria cri);
	
	@Select("<script>"
				+ "SELECT count(*) FROM notice JOIN member USING (mno) WHERE nvis = 1 AND "
				+ "<trim prefix=\"(\" suffix=\") AND \" prefixOverrides=\"OR\">"
					+ "<foreach item='type' collection=\"typeArr\">"
						+ "<trim prefix=\"OR\">"
							+ "<choose>"
								+ "<when test=\"type == 'T'.toString()\">"
									+ "ntitle LIKE '%'||#{keyword}||'%'"
								+ "</when>"
								+ "<when test=\"type == 'C'.toString()\">"
									+ "ncontent LIKE '%'||#{keyword}||'%'"
								+ "</when>"
								+ "<when test=\"type == 'W'.toString()\">"
									+ "UPPER(nick) LIKE UPPER('%'||#{keyword}||'%')"
								+ "</when>"
							+ "</choose>"
						+ "</trim>"
					+ "</foreach>"
				+ "</trim>"
			+ "nno > 0"
		+ "</script>")
	public int getTotalCount(Criteria cri);
	
}
