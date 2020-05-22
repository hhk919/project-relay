package relay.mapper.wishlist;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import relay.vo.product.ProductVO;
import relay.vo.wishlist.WishlistVO;

public interface WishlistMapper {

	@Select("SELECT * FROM wishlist JOIN member USING (mno) JOIN product USING (pno) WHERE mno = #{mno}")
	public List<WishlistVO> getWishlist(@Param("mno") String mno);
	
	@Insert("INSERT INTO wishlist (mno, pno) VALUES ( #{mno}, (SELECT pno FROM product WHERE pid = #{pid} ) )")
	public int insertWishlist(@Param("pid") Long pid, @Param("mno") int mno);

	@Delete("DELETE FROM wishlist WHERE pno = #{pno} AND mno = #{mno}")
	public int deleteWishlist(@Param("pno") String pno, @Param("mno") String mno);

	@Select("SELECT count(*) FROM wishlist WHERE mno = #{mno}")
	public int getTotal(String mno);

	@Update("UPDATE wishlist SET grade = #{grade} WHERE pno = #{pno} AND mno = #{mno}")
	public int updateGrade(@Param("pno") String pno, @Param("mno") String mno, @Param("grade") int grade);

	@Select("SELECT * FROM "
			+ "(SELECT DISTINCT w.pno, p.pname, p.pimg, p.phprice, p.plprice, p.pmallurl, p.pmall, p.catid, p.pid , c.xcat, c.lcat, c.mcat, c.scat, COUNT(*) AS cnt "
			+ "FROM wishlist w LEFT JOIN product p ON w.pno = p.pno LEFT JOIN category c ON p.catid = c.catid "
			+ "GROUP BY w.pno, p.pname, p.pimg, p.phprice, p.plprice, p.pmallurl, p.pmall, p.catid, p.pid , c.xcat, c.lcat, c.mcat, c.scat " 
			+ "ORDER BY cnt DESC) WHERE rownum <= 5")
	public List<ProductVO> getMostWishedList();
	
}
