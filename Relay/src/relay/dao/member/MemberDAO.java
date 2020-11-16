package relay.dao.member;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import relay.vo.member.MemberVO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSessionFactory factory;

	/*
	 * public MemberVO select(MemberVO vo) { MemberVO result = null; try {
	 * 
	 * result = factory.openSession().selectOne("admin.selectMember", vo); } catch
	 * (Exception e) { e.printStackTrace();
	 * 
	 * } System.out.println(result.getId()); return result; }
	 */

	public List<MemberVO> getList() {
		List<MemberVO> list = null;
		try {
			list = factory.openSession().selectList("admin.selectAllMember");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	/*
	 * public MemberVO info(int mno) { MemberVO vo = null; try { vo =
	 * factory.openSession().selectOne("admin.selectMember", mno); } catch
	 * (Exception e) { e.printStackTrace(); } return vo; }
	 */

	public int deleteMemberForAdmin(int mno) {
		int a = 0;
		try {
//			a = factory.openSession().selectOne("admin.deleteMember", mno);
			a = factory.openSession().delete("admin.deleteMember", mno);			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return a;
	}
	
	public int deleteMemeber(MemberVO vo) {
		int n = factory.openSession().update("member.deleteMember", vo);
		return n;
	}

	public int deleteMemberFromDb(int mno) {
		int a = 0;
		try {
//			a = factory.openSession().selectOne("admin.deleteMember", mno);
			a = factory.openSession().delete("admin.deleteMember2", mno);			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return a;
	}
	
	public String insertMemeber(MemberVO vo) {
		String result = null;
		try {
			int n = factory.openSession().insert("member.insertMember", vo);
			if (n==1) {
				factory.openSession().commit();
				result = vo.getId();
			} else {
				factory.openSession().rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public int updateMember(MemberVO vo) {
		int result = 0;
		try {
			result = factory.openSession().update("member.updateMember", vo);
			if (result > 0) {
				factory.openSession().commit();
			} else {
				factory.openSession().rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public MemberVO getMemeber(MemberVO vo) {
		MemberVO result = null;
		try {
			result = factory.openSession().selectOne("member.getMember", vo);
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return result;
	}

	public int validateID(String id) {
		int check = 0;
		try {
			check = factory.openSession().selectOne("member.validateID", id);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return check;
	}

	public int validateNick(String nick) {
		int check = 0;
		try {
			check = factory.openSession().selectOne("member.validateNick", nick);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return check;
	}

	public MemberVO getMemberNick(String nick) {
		MemberVO vo = null;
		try {
			vo = factory.openSession().selectOne("member.getMemberNick",nick);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	public int getMemberNO(String nick) {
		int result = 0;
		try {
			result = factory.openSession().selectOne("member.getMemberNO", nick);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
