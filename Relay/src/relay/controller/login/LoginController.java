package relay.controller.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;

import relay.biz.login.LoginBIZ;
import relay.vo.member.MemberVO;

@Controller
public class LoginController {

	@Autowired
	private LoginBIZ lBiz;

	@RequestMapping("/memberlogin.do")
	public ModelAndView getMember(MemberVO vo, HttpServletRequest request) {
		MemberVO vo1 = lBiz.getMember(vo);// DB에서 ID/pw를 가지고 레코드를 추출한 결과
		ModelAndView mav = null;
		String a=vo.getId();
		String b=vo.getPw();

		if (vo1 == null) {		
			mav = new ModelAndView("login/loginresult");
		} else if(a.equals(vo1.getId()) && b.equals(vo1.getPw())) {
			HttpSession session = request.getSession();
			session.setAttribute("vo1", vo1);
			session.setAttribute("id", vo1.getId());
			vo1.setLogonTime(System.currentTimeMillis());
			mav = new ModelAndView("login/loginresult");
		}
		return mav;
	}
	
	@RequestMapping("/memberlogout.do")
	public ModelAndView outMember(HttpServletRequest request) {
		ModelAndView mav = null;
		HttpSession session = request.getSession();
		MemberVO vo = new MemberVO();
		vo = (MemberVO) session.getAttribute("vo1");
		vo.setLogonTime(System.currentTimeMillis() - vo.getLogonTime());
		mav = new ModelAndView();
		mav.setViewName("login/logout");
		mav.addObject("vo1",vo);
		session.invalidate();
		return mav;
	}

}
