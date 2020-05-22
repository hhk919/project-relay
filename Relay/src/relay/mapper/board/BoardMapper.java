package relay.mapper.board;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import relay.vo.board.BoardVO;
import relay.common.Criteria;

public interface BoardMapper {

	@Select("SELECT /*+ INDEX_DESC(board pk_brd) */ * FROM board JOIN member USING (mno) ORDER BY bno DESC")
	public List<BoardVO> getList();
	
	@Select("SELECT /*+ INDEX_DESC(board pk_brd) */ * FROM board JOIN member USING (mno) ORDER BY bno DESC")
	public List<BoardVO> getListForAdmin();
	
	@Select("SELECT * FROM board JOIN member USING (mno) WHERE bno = #{bno}")
	public BoardVO getPost(String bno);
	
	@Update("UPDATE board SET bcnt = bcnt+1 WHERE bno = #{bno}")
	public int increaseCount(String bno);
	
	@Insert("INSERT INTO board(bno, btitle, bcontent, mno, btag) VALUES(bno.nextval, #{btitle}, #{bcontent}, #{mno}, #{btag})")
	public int insertPost(BoardVO vo);
	
	@Insert("INSERT INTO board(bno, btitle, bcontent, mno, btag, bimg, bimgurl) VALUES(bno.nextval, #{btitle}, #{bcontent}, #{mno}, #{btag}, #{bimg}, #{bimgurl})")
	public int insertPostWithImg(BoardVO vo);

	@Update("UPDATE board SET btitle = #{btitle}, bupdate = sysdate, bcontent = #{bcontent}, btag = #{btag} WHERE bno = #{bno}")
	public int updatePost(BoardVO vo);
	
	@Update("UPDATE board SET btitle = #{btitle}, bupdate = sysdate, bcontent = #{bcontent}, btag = #{btag}, bimg = #{bimg}, bimgurl = #{bimgurl} WHERE bno = #{bno}")
	public int updatePostWithImg(BoardVO vo);

	@Update("UPDATE board SET bvis= 0 WHERE bno = #{bno}")
	public int deletePost(String bno);
	
	@Update("UPDATE board SET breplycnt = (SELECT count(*) FROM comm WHERE bno = #{bno} AND cvis = 1) WHERE bno = #{bno}")
	public int updateReplyCNT(int bno);

	@Select("<script>"
			+ "SELECT rownum rn, bno, btitle, bcontent, mno, bdate, bupdate, btag, nick, breplycnt, bcnt "
			+ "FROM "
				+ "("
				+ "SELECT /*+ INDEX_DESC(board pk_brd) */ rownum rn, bno, btitle, bcontent, mno, bdate, bupdate, btag, nick, breplycnt, bcnt "
				+ "FROM "
				+ "board JOIN member USING (mno) "
				+ "WHERE bvis = 1 AND "
					+ "<trim prefix=\"(\" suffix=\") AND \" prefixOverrides=\"OR\">"
						+ "<foreach item='type' collection=\"typeArr\">"
							+ "<trim prefix=\"OR\">"
								+ "<choose>"
									+ "<when test=\"type == 'T'.toString()\">"
										+ "btitle LIKE '%'||#{keyword}||'%'"
									+ "</when>"
									+ "<when test=\"type == 'C'.toString()\">"
										+ "bcontent LIKE '%'||#{keyword}||'%'"
									+ "</when>"
									+ "<when test=\"type == 'W'.toString()\">"
										+ "UPPER(nick) LIKE UPPER('%'||#{keyword}||'%')"
									+ "</when>"
									+ "<when test=\"type == 'H'.toString()\">"
										+ "btag LIKE '%'||#{keyword}||'%'"
									+ "</when>"	
								+ "</choose>"
							+ "</trim>"
						+ "</foreach>"
					+ "</trim>"
			+ "<![CDATA[ rownum <= #{pageNum} * #{amount}"
			+ ") "
			+ "WHERE "
			+ "rn > (#{pageNum} -1) * #{amount} ]]>"
			+ "</script>")
	public List<BoardVO> searchWithPaging(Criteria cri);
	
	@Select("<script>"
				+ "SELECT COUNT(*) FROM board JOIN member USING (mno) WHERE bvis = 1 AND "
				+ "<trim prefix=\"(\" suffix=\") AND \" prefixOverrides=\"OR\">"
					+ "<foreach item='type' collection=\"typeArr\">"
						+ "<trim prefix=\"OR\">"
							+ "<choose>"
								+ "<when test=\"type == 'T'.toString()\">"
									+ "btitle LIKE '%'||#{keyword}||'%'"
								+ "</when>"
								+ "<when test=\"type == 'C'.toString()\">"
									+ "bcontent LIKE '%'||#{keyword}||'%'"
								+ "</when>"
								+ "<when test=\"type == 'W'.toString()\">"
									+ "UPPER(nick) LIKE UPPER('%'||#{keyword}||'%')"
								+ "</when>"
								+ "<when test=\"type == 'H'.toString()\">"
									+ "btag LIKE '%'||#{keyword}||'%'"
								+ "</when>"	
							+ "</choose>"
						+ "</trim>"
					+ "</foreach>"
				+ "</trim>"
			+ "bno > 0"
		+ "</script>")
	public int getTotal(Criteria cri);
	
}
