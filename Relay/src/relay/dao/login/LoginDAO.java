package relay.dao.login;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import relay.vo.member.MemberVO;

@Repository
public class LoginDAO {

	@Autowired
	private SqlSessionFactory factory;

	public MemberVO getMember(MemberVO vo) {
		MemberVO vo1 = null;
		try {
			vo1 = (MemberVO) factory.openSession().selectOne("selectMember", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo1;
	}

}
