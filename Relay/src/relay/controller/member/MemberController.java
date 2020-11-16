package relay.controller.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import relay.biz.member.MemberBIZ;
import relay.vo.member.MemberVO;

@Controller
public class MemberController {
	
	@Autowired
	MemberBIZ mBiz;

	@RequestMapping("/adminMemberList.do")
	public String getList(Model model) {
		List<MemberVO> list = mBiz.getList();
		model.addAttribute("list", list);
		return "/admin/memberMlist";
	}

	@RequestMapping("/memberMdeleteAdmin.do")
	public void deleteMemberForAdmin(@RequestParam("mno") int mno, HttpServletResponse response) {
		mBiz.deleteMemberForAdmin(mno);
		try {
			response.sendRedirect("adminMemberList.do");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/memberdelete.do")
	public ModelAndView deleteMemeber(MemberVO vo, HttpServletRequest request) {
		HttpSession session = request.getSession();
		int res = mBiz.deleteMember(vo);
		if (res == 2) {
			session.invalidate();
		}
		ModelAndView mav = new ModelAndView("member/memberout", "result", res);
		return mav;
	}

	@RequestMapping("/memberMdelete2Admin.do")
	public void deleteMemberFromDb(@RequestParam("mno") int mno, HttpServletResponse response) {
		mBiz.deleteMemberFromDb(mno);
		try {
			response.sendRedirect("adminMemberList.do");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/memberInsert.do")
	public ModelAndView insertMember(MemberVO vo) {
		String result = mBiz.insertMember(vo);
		ModelAndView mav = new ModelAndView("member/memberresult", "memberresult", result);
		return mav;
	}
	
	@RequestMapping("/memberRead.do")
	public String getMemeber() {	
		return "member/mypage";
		
	}
	
	@RequestMapping("/memberupdate.do")
	public ModelAndView updateMemeber(MemberVO vo, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("vo1");
		
		mBiz.updateMemeber(vo);
		MemberVO vo1 = mBiz.getMemeber(vo);

		ModelAndView mav = new ModelAndView();
		session.setAttribute("vo1", vo1);
		mav.setViewName("member/mypage");
		return mav;
	}
	
	@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String validateID(@RequestParam("id") String id) {
		String str = "";
		int check = mBiz.validateID(id);
		if(check == 1) {
			str = "no";
		}else {
			str = "yes";
		}
		return str;
	}
	
	@RequestMapping(value = "/nickCheck.do", method = RequestMethod.POST)
	@ResponseBody
	public String validateNick(@RequestParam("nick") String nick) {
		String str = "";
		int check = mBiz.validateNick(nick);
		if(check == 1) {
			str = "no";
		}else {
			str = "yes";
		}
		return str;
	}
	
	@RequestMapping("/member/getMemberNick.do")
	@ResponseBody
	public MemberVO getMemberNick(@RequestParam("memberNick") String nick){
		MemberVO vo = mBiz.getMemberNick(nick);
		return vo;
	}
}
