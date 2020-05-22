package relay.biz.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import relay.dao.member.MemberDAO;
import relay.vo.member.MemberVO;

@Service
public class MemberBIZ {

	@Autowired
	MemberDAO dao;

	public List<MemberVO> getList() {
		return dao.getList();
	}

	public int deleteMemberForAdmin(int mno) {

		return dao.deleteMemberForAdmin(mno);
	}

	public int deleteMember(MemberVO vo) {

		return dao.deleteMemeber(vo);
	}

	public int deleteMemberFromDb(int mno) {
		return dao.deleteMemberFromDb(mno);
	}

	public String insertMember(MemberVO vo) {

		int r = vo.getBirth() / 10000;
		System.out.println(r);
		if (r >= 0 && r <= 9) {
			vo.setAge(10);
		} else if (r >= 90 && r <= 99) {
			vo.setAge(20);
		} else if (r >= 80 && r <= 89) {
			vo.setAge(30);
		} else if (r >= 70 && r <= 79) {
			vo.setAge(40);
		} else if (r >= 60 && r <= 69) {
			vo.setAge(50);
		} else if (r < 60 && r > 19) {
			vo.setAge(60);
		}

		int s = vo.getSex();
		if (s == 1 || s == 3) {
			vo.setGender("남자");
		} else {
			vo.setGender("여자");
		}

		return dao.insertMemeber(vo);
	}

	public int updateMemeber(MemberVO vo) {
		return dao.updateMember(vo);
	}

	public MemberVO getMemeber(MemberVO vo) {
		return dao.getMemeber(vo);
	}

	public int validateID(String id) {
		return dao.validateID(id);
	}

	public int validateNick(String nick) {
		return dao.validateNick(nick);
	}

	public MemberVO getMemberNick(String nick) {
		return dao.getMemberNick(nick);
	}
	
	public int getMemberNO(String nick) {
		return dao.getMemberNO(nick);
	}

}
