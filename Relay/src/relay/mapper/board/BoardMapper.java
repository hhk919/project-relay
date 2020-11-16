package relay.mapper.board;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import relay.vo.board.BoardVO;
import relay.common.Criteria;

public interface BoardMapper {

	@Select("SELECT n.bno, n.btag, n.btitle,  FROM relay.board JOIN member USING (mno) ORDER BY bno DESC")
	public List<BoardVO> getList();
	
	@Select("SELECT b.bno, b.btag, b.btitle, b.bdate, b.bupdate, b.bvis, b.bcnt, m.nick FROM relay.board b JOIN relay.member m USING (mno) ORDER BY bno DESC")
	public List<BoardVO> getListForAdmin();
	
	@Select("SELECT b.*, m.nick FROM relay.board b LEFT JOIN relay.member m USING (mno) WHERE bno = #{bno}")
	public BoardVO getPost(String bno);
	
	@Update("UPDATE relay.board SET bcnt = bcnt+1 WHERE bno = #{bno}")
	public int increaseCount(String bno);
	
	@Insert("INSERT INTO relay.board(btitle, bcontent, mno, btag) VALUES (#{btitle}, #{bcontent}, #{mno}, #{btag})")
	public int insertPost(BoardVO vo);
	
	@Insert("INSERT INTO relay.board(btitle, bcontent, mno, btag, bimg, bimgurl) VALUES (#{btitle}, #{bcontent}, #{mno}, #{btag}, #{bimg}, #{bimgurl})")
	public int insertPostWithImg(BoardVO vo);

	@Update("UPDATE relay.board SET btitle = #{btitle}, bupdate = now(), bcontent = #{bcontent}, btag = #{btag} WHERE bno = #{bno}")
	public int updatePost(BoardVO vo);
	
	@Update("UPDATE relay.board SET btitle = #{btitle}, bupdate = now(), bcontent = #{bcontent}, btag = #{btag}, bimg = #{bimg}, bimgurl = #{bimgurl} WHERE bno = #{bno}")
	public int updatePostWithImg(BoardVO vo);

	@Update("UPDATE relay.board SET bvis= 0 WHERE bno = #{bno}")
	public int deletePost(String bno);
	
	@Update("UPDATE relay.board SET breplycnt = (SELECT count(1) FROM relay.comm WHERE bno = #{bno}) WHERE bno = #{bno}")
	public int updateReplyCNT(int bno);

	@Select("<script>"
			+ "SELECT *, nick "
			+ "FROM relay.board B USE INDEX (primary) LEFT JOIN relay.member M USING (mno) "
			+ "WHERE bvis = 1"
			+ "<if test=\"keyword != null\">"
				+ "<trim prefix=\" AND (\" suffix=\")\" prefixOverrides=\"OR\">"
					+ "<foreach item='type' collection=\"typeArr\">"
						+ "<trim prefix=\"OR\">"
							+ "<choose>"
								+ "<when test=\"type == 'T'.toString()\">"
									+ "btitle LIKE CONCAT('%',#{keyword},'%')"
								+ "</when>"
								+ "<when test=\"type == 'C'.toString()\">"
									+ "bcontent LIKE CONCAT('%',#{keyword},'%')"
								+ "</when>"
								+ "<when test=\"type == 'W'.toString()\">"
									+ "UPPER(nick) LIKE UPPER(CONCAT('%',#{keyword},'%'))"
								+ "</when>"
								+ "<when test=\"type == 'H'.toString()\">"
									+ "btag LIKE CONCAT('%',#{keyword},'%')"
								+ "</when>"	
							+ "</choose>"
						+ "</trim>"
					+ "</foreach>"
				+ "</trim>"
			+ "</if>"
			+ " ORDER BY BNO DESC LIMIT #{offset}, #{amount}"
			+ "</script>")
	public List<BoardVO> searchWithPaging(Criteria cri);
	
	@Select({"<script>",
			"SELECT COUNT(1) FROM relay.board B JOIN relay.member M USING (mno) WHERE bvis = 1"
				+ "<if test=\"keyword != null\">"
				+ "<trim prefix=\" AND (\" suffix=\")\" prefixOverrides=\"OR\">"
					+ "<foreach item='type' collection=\"typeArr\">"
						+ "<trim prefix=\"OR\">"
							+ "<choose>"
								+ "<when test=\"type == 'T'.toString()\">"
									+ "btitle LIKE CONCAT('%',#{keyword},'%')"
								+ "</when>"
								+ "<when test=\"type == 'C'.toString()\">"
									+ "bcontent LIKE CONCAT('%',#{keyword},'%')"
								+ "</when>"
								+ "<when test=\"type == 'W'.toString()\">"
									+ "UPPER(nick) LIKE UPPER(CONCAT('%',#{keyword},'%'))"
								+ "</when>"
								+ "<when test=\"type == 'H'.toString()\">"
									+ "btag LIKE CONCAT('%',#{keyword},'%')"
								+ "</when>"	
							+ "</choose>"
						+ "</trim>"
					+ "</foreach>"
				+ "</trim>"
				+ "</if>"	
			+ "</script>"})
	public int getTotal(Criteria cri);
	
}
