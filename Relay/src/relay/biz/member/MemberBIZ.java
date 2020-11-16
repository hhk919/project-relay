package relay.biz.member;

import java.util.List;
import java.time.LocalDate;


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

		int year = vo.getBirth() / 10000;
		int now = LocalDate.now().getYear();
		if (year>=0 && year<=(now - 2000)) {
			int age = (int) ((now-(2000+year))/10*10);
			if(age<=10) {
				vo.setAge(10);
			}
			else if (age>=60) {
				vo.setAge(60);
			}
			else {
				vo.setAge(age);
			}
			
		}
		else {
			int age = (int) ((now-(1900+year))/10*10);
			vo.setAge(age);
			
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
	
//	public int getMemberNO(String nick) {
//		return dao.getMemberNO(nick);
//	}

}
