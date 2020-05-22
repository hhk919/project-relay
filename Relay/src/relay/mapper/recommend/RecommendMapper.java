package relay.mapper.recommend;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import relay.vo.recommend.RecommendVO;

public interface RecommendMapper {
	
	@Select("SELECT * "+ 
			"FROM product "+ 
			"WHERE pno in (#{pno1},#{pno2},#{pno3},#{pno4},#{pno5}) ")
	public List<RecommendVO> getRecommendListByWishlist(@Param("pno1") int pno1, @Param("pno2") int pno2, @Param("pno3") int pno3, @Param("pno4") int pno4, @Param("pno5") int pno5);
	
	@Select("SELECT * FROM " + 
			"(SELECT w.pno, p.pname, p.pimg, p.phprice, p.plprice, p.catid, p.pmallurl, COUNT(*) AS cnt " + 
			"FROM wishlist w LEFT JOIN product p on w.pno = p.pno " + 
			"LEFT JOIN detail d on w.mno=d.mno " + 
			"WHERE d.age = #{age} " + 
			"GROUP BY w.pno, p.pname, p.pimg, p.phprice, p.plprice, p.catid, p.pmallurl ORDER BY cnt DESC) " + 
			"WHERE rownum <= 5")
	public List<RecommendVO> getRecommendListByAge(int age);

	@Select("SELECT * FROM " + 
			"(SELECT w.pno, p.pname, p.pimg, p.phprice, p.plprice, p.catid, p.pmallurl, COUNT(*) AS cnt " + 
			"FROM wishlist w LEFT JOIN product p on w.pno = p.pno " + 
			"LEFT JOIN detail d on w.mno=d.mno " + 
			"WHERE d.gender = #{gender} " + 
			"GROUP BY w.pno, p.pname, p.pimg, p.phprice, p.plprice, p.catid, p.pmallurl ORDER BY cnt DESC) " + 
			"WHERE rownum <= 5")
	public List<RecommendVO> getRecommendListByGender(String gender);

	@Select("SELECT * FROM " + 
			"(SELECT w.pno, p.pname, p.pimg, p.phprice, p.plprice, p.catid, p.pmallurl, COUNT(*) AS cnt " + 
			"FROM wishlist w LEFT JOIN product p on w.pno = p.pno " + 
			"LEFT JOIN detail d on w.mno=d.mno " + 
			"WHERE d.hobby = #{hobby} " + 
			"GROUP BY w.pno, p.pname, p.pimg, p.phprice, p.plprice, p.catid, p.pmallurl ORDER BY cnt DESC) " + 
			"WHERE rownum <= 5")
	public List<RecommendVO> getRecommendListByHobby(String hobby);

	@Select("SELECT * FROM " + 
			"(SELECT w.pno, p.pname, p.pimg, p.phprice, p.plprice, p.catid, p.pmallurl, COUNT(*) AS cnt " + 
			"FROM wishlist w LEFT JOIN product p on w.pno = p.pno " + 
			"LEFT JOIN detail d on w.mno=d.mno " + 
			"WHERE d.age = #{age} and d.gender = #{gender} and d.hobby = #{hobby} " + 
			"GROUP BY w.pno, p.pname, p.pimg, p.phprice, p.plprice, p.catid, p.pmallurl ORDER BY cnt DESC) " + 
			"WHERE rownum <= 5")
	public List<RecommendVO> getRecommendListByAgeGenderHobby(@Param("age") int age, @Param("gender") String gender, @Param("hobby") String hobby);
	
}
