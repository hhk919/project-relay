package relay.biz.recommend;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.List;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import relay.dao.recommend.RecommendDAO;
import relay.vo.recommend.RecommendVO;

@Service
public class RecommendBIZ {

	@Autowired
	private RecommendDAO dao;
	
	public List<RecommendVO> getRecommendListByWishlist(int mno) {
		String pnos = null;
		int pno1 = 0;
		int pno2 = 0;
		int pno3 = 0;
		int pno4 = 0;
		int pno5 = 0;
		try {
			String smno = String.valueOf(mno);
			String[] cmdArray = { "python.exe", "C:\\Users\\Playdata\\Desktop\\Relay\\src\\resources\\recommend.py", smno};
			Process p = Runtime.getRuntime().exec(cmdArray);
			BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
			pnos = br.readLine();
			StringTokenizer str = new StringTokenizer(pnos, "(,) ");
			while(str.hasMoreTokens()) {
				pno1 = Integer.parseInt(str.nextToken());
				pno2 = Integer.parseInt(str.nextToken());
				pno3 = Integer.parseInt(str.nextToken());
				pno4 = Integer.parseInt(str.nextToken());
				pno5 = Integer.parseInt(str.nextToken());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return dao.getRecommendListByWishlist(pno1, pno2, pno3, pno4, pno5);
	}
	
	public List<RecommendVO> getRecommendListByAge(int age) {
		return dao.getRecommendListByAge(age);
	}

	public List<RecommendVO> getRecommendListByGender(String gender) {
		return dao.getRecommendListByGender(gender);
	}

	public List<RecommendVO> getRecommendListByHobby(String hobby) {
		return dao.getRecommendListByHobby(hobby);
	}

	public List<RecommendVO> getRecommendListByAgeGenderHobby(int age, String gender, String hobby) {
		return dao.getRecommendListByAgeGenderHobby(age, gender, hobby);
	}
}
