package relay.controller.notice;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import relay.biz.notice.NoticeBIZ;
import relay.common.Criteria;
import relay.common.PageDTO;
import relay.vo.notice.NoticeVO;

@RestController
public class NoticeController {
	
	@Autowired
	private NoticeBIZ nBiz;
	
	@RequestMapping("/noticeList.do")
	public String getList(@PathParam("type") Criteria cri, Model model) {
		int total = nBiz.getTotal(cri);
		PageDTO pageMaker = new PageDTO(cri, total);
		List<NoticeVO> list = nBiz.getList(cri);
		model.addAttribute("list",list);
		model.addAttribute("pageMaker",pageMaker);
		return "notice/list";
	}
	
	@RequestMapping("/noticeListAdmin.do")
	public ModelAndView getListForAdmin() {
		List<NoticeVO> noticeList = nBiz.getListForAdmin();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/noticeMlist");
		mav.addObject("adminlist", noticeList);

		return mav;
	}
	
	@RequestMapping("/notice/getListForMain.do")
	public List<NoticeVO> getListForMain() {
		List<NoticeVO> list = nBiz.getListForMain();
		return list;
	}
	
	@RequestMapping("/noticeRead.do")
	public ModelAndView getPost(@RequestParam("nno") String nno) {
		NoticeVO vo = nBiz.getPost(nno);
		nBiz.increaseCount(nno);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("notice/view");
		mav.addObject("vo", vo);
		return mav;
	}
	
	@RequestMapping("/noticeReadAdmin.do")
	public ModelAndView getPostForAdmin(@RequestParam("nno") String nno) {
		NoticeVO vo = nBiz.getPost(nno);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/noticeMview");
		mav.addObject("vo", vo);
		return mav;
	}
	
	@RequestMapping("/noticeInsertAdmin.do")
	public ModelAndView insertPost(NoticeVO vo) {
		String result = nBiz.insertPost(vo);
		ModelAndView mav = new ModelAndView("admin/noticeMresult", "result", result);
		return mav;
	}
	
	@RequestMapping("/noticeWriteAdmin.do")
	public String redirectToWritePost() {
		return "notice/write";
	}
	
	@RequestMapping("/noticeDeleteAdmin.do")
	public void deletePost(@RequestParam("nno") String nno, HttpServletResponse response) {
		nBiz.deletePost(nno);
		try {
			response.sendRedirect("noticeListAdmin.do");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/noticeUpdateAdmin.do")
	public ModelAndView updatePost(NoticeVO vo, HttpServletResponse response) {
		int result = nBiz.updatePost(vo);
		ModelAndView mav = new ModelAndView("admin/noticeMupdated", "result", result);
		return mav;
	}
	
	@RequestMapping("/noticeGetForUpdateAdmin.do")
	public ModelAndView getPostForUpdate(@PathParam("nno") String nno) {
		NoticeVO vo = nBiz.getPostForUpdate(nno);
		ModelAndView mav = new ModelAndView("admin/noticeMupdate", "vo", vo);
		return mav;
	}
}
