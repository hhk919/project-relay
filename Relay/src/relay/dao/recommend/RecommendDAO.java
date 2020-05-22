package relay.dao.recommend;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import relay.mapper.recommend.RecommendMapper;
import relay.vo.recommend.RecommendVO;

@Repository
public class RecommendDAO {

	@Autowired
	private SqlSessionFactory factory;

	public List<RecommendVO> getRecommendListByWishlist(int pno1, int pno2, int pno3, int pno4, int pno5) {
		List<RecommendVO> list = null;
		try {
			RecommendMapper mapper = factory.openSession().getMapper(RecommendMapper.class);
			list = mapper.getRecommendListByWishlist(pno1, pno2, pno3, pno4, pno5);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<RecommendVO> getRecommendListByAge(int age) {
		List<RecommendVO> list = null;
		try {
			RecommendMapper mapper = factory.openSession().getMapper(RecommendMapper.class);
			list = mapper.getRecommendListByAge(age);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<RecommendVO> getRecommendListByGender(String gender) {
		List<RecommendVO> list = null;
		try {
			RecommendMapper mapper = factory.openSession().getMapper(RecommendMapper.class);
			list = mapper.getRecommendListByGender(gender);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<RecommendVO> getRecommendListByHobby(String hobby) {
		List<RecommendVO> list = null;
		try {
			RecommendMapper mapper = factory.openSession().getMapper(RecommendMapper.class);
			list = mapper.getRecommendListByHobby(hobby);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<RecommendVO> getRecommendListByAgeGenderHobby(int age, String gender, String hobby) {
		List<RecommendVO> list = null;
		try {
			RecommendMapper mapper = factory.openSession().getMapper(RecommendMapper.class);
			list = mapper.getRecommendListByAgeGenderHobby(age, gender, hobby);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
