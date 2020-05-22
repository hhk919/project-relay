package relay.biz.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import relay.dao.login.LoginDAO;
import relay.vo.member.MemberVO;

@Service
public class LoginBIZ {

		@Autowired
		LoginDAO dao;

		public MemberVO getMember(MemberVO vo) {
			return dao.getMember(vo);
		}
		
	

}
