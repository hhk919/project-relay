package relay.controller.board;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import relay.biz.board.BoardBIZ;
import relay.biz.notice.NoticeBIZ;
import relay.vo.board.BoardVO;
import relay.vo.notice.NoticeVO;
import relay.common.PageDTO;
import relay.common.Criteria;

@Controller
public class BoardController {
	
	@Autowired
	private BoardBIZ bBiz;
	
	@Autowired
	private NoticeBIZ nBiz;
	
	@RequestMapping("/boardList.do")
	public String getList(@PathParam("type") Criteria cri, Model model) {
		cri.setOffset((cri.getPageNum()-1)*cri.getAmount());
		int total = bBiz.getTotal(cri);
		List<BoardVO> boardList = bBiz.getList(cri);
		PageDTO pageMaker = new PageDTO(cri, total);
		List<NoticeVO> noticeList = nBiz.getListForBoard();
		model.addAttribute("list_notice",noticeList);
		model.addAttribute("list",boardList);
		model.addAttribute("pageMaker",pageMaker);
		
		return "board/list";
	}
	
	@RequestMapping("/boardListAdmin.do")
	public ModelAndView list() {
		List<BoardVO> boardList = bBiz.getListForAdmin();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/boardMlist");
		mav.addObject("adminlist", boardList);
		return mav;
	}
	
	@RequestMapping("/boardListForMember.do")
	public String getListForMember(@PathParam("type") Criteria cri, @RequestParam("nick") String nick, Model model) {
		cri.setKeyword(nick);
		cri.setType("W");
		int total = bBiz.getTotal(cri);
		cri.setOffset((cri.getPageNum()-1)*cri.getAmount());
		List<BoardVO> boardList = bBiz.getList(cri);
		PageDTO pageMaker = new PageDTO(cri, total);
		List<NoticeVO> noticeList = nBiz.getListForBoard();
		model.addAttribute("list_notice",noticeList);
		model.addAttribute("list",boardList);
		model.addAttribute("pageMaker",pageMaker);
		return "board/list";
	}
	
	@RequestMapping("/boardListForTag.do")
	public String getListForTag(@PathParam("type") Criteria cri, @RequestParam("btag") String btag, Model model) {
		cri.setKeyword(btag);
		cri.setType("H");
		int total = bBiz.getTotal(cri);
		cri.setOffset((cri.getPageNum()-1)*cri.getAmount());
		List<BoardVO> boardList = bBiz.getList(cri);
		PageDTO pageMaker = new PageDTO(cri, total);
		List<NoticeVO> noticeList = nBiz.getListForBoard();
		model.addAttribute("list_notice",noticeList);
		model.addAttribute("list",boardList);
		model.addAttribute("pageMaker",pageMaker);
		return "board/list";
	}
	
	@RequestMapping("/boardDelete.do")
	public void deletePost(@RequestParam("bno") String bno, HttpServletResponse response) {
		bBiz.deletePost(bno);
		try {
			response.sendRedirect("boardList.do");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/boardDeleteAdmin.do")
	public void deletePostForAdmin(@RequestParam("bno") String bno, HttpServletResponse response) {
		bBiz.deletePost(bno);
		try {
			response.sendRedirect("boardListAdmin.do");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("/boardRead.do")
	public ModelAndView getPost(@RequestParam("bno") String bno) {
		BoardVO vo = bBiz.getPost(bno);
		ModelAndView mav = new ModelAndView();
		bBiz.increaseCount(bno);
		mav.addObject("vo", vo);
		mav.setViewName("board/view");
		return mav;
	}
	
	@RequestMapping("/boardReadAdmin.do")
	public ModelAndView getPostForAdmin(@RequestParam("bno") String bno) {
		BoardVO vo = bBiz.getPost(bno);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("admin/boardMview");
		mav.addObject("vo", vo);
		return mav;
	}
	
	@RequestMapping("/download.do")
	@ResponseBody
	public byte[] downloadImg(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam String filename) throws IOException{
		String path= request.getServletContext().getRealPath("/img");
		File file
		= new File(path + "/" +filename);

		byte[] bytes = FileCopyUtils.copyToByteArray(file);
		String fn = new String(file.getName().getBytes(), "8859_1");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fn + "\"");
		response.setContentLength(bytes.length);
		response.setContentType("image/jpeg");
		return bytes;
	}
	
	@RequestMapping("/boardGetForUpdate.do")
	public ModelAndView searchForUpdate(@PathParam("bno") String bno) {
		BoardVO vo = bBiz.getPost(bno);
		ModelAndView mav = new ModelAndView("board/update", "vo", vo);
		return mav;
	}
	
	@RequestMapping("/board/updateReplyCNT.do")
	@ResponseBody
	public int updateReplyCNT(@PathParam("bno") int bno) {
		int result = 0;
		result = bBiz.updateReplyCNT(bno);
		return result;
	}
	
	@RequestMapping("/boardWrite.do")
	public String redirectToWritePost() {
		return "board/write";
	}
	
	@RequestMapping("/boardInsert.do")
	public ModelAndView insertPost(BoardVO vo, HttpServletRequest request) {
		MultipartFile file= vo.getFile();
		String filename= file.getOriginalFilename();
		String path= request.getServletContext().getRealPath("/img");
		
		if(filename != "") {
			vo.setBimg(filename);
			vo.setBimgurl(path);
			
			InputStream inputStream = null;
			OutputStream outputStream = null;
			try {
				inputStream = file.getInputStream();
				File newFile
				= new File(path + "/" + filename);
				if(! newFile.exists()) {
					newFile.createNewFile();
				}
				
				outputStream = new FileOutputStream(newFile);
				int read=0;
				byte[] b= new byte[(int)file.getSize()];
				while((read = inputStream.read(b)) !=-1) {
					outputStream.write(b,0,read);
				}
			}catch(IOException e) {
				e.printStackTrace();
			}finally {
				try {
					inputStream.close();
					outputStream.close();
				}catch(IOException e) {}
			}
		}else{
			String result = bBiz.insertPost(vo);
			ModelAndView mav = new ModelAndView("board/result","result",result);
			return mav;
		}
		
		String result = bBiz.insertPostWithImg(vo);
		ModelAndView mav = new ModelAndView("board/result","result",result);
		return mav;
	}
	
	@RequestMapping("/boardUpdate.do")
	public ModelAndView updatePost(@PathParam ("bno") BoardVO vo, HttpServletRequest request) {
		MultipartFile file= vo.getFile();
		String filename= file.getOriginalFilename();
		String path= request.getServletContext().getRealPath("/img");

		if(filename != "") {
			vo.setBimg(filename);
			vo.setBimgurl(path);
			
			InputStream inputStream = null;
			OutputStream outputStream = null;
			try {
				inputStream = file.getInputStream();
				File newFile
				= new File(path + "/" + filename);
				if(! newFile.exists()) {
					newFile.createNewFile();
				}
				
				outputStream = new FileOutputStream(newFile);
				int read=0;
				byte[] b= new byte[(int)file.getSize()];
				while((read = inputStream.read(b)) !=-1) {
					outputStream.write(b,0,read);
				}
			}catch(IOException e) {
				e.printStackTrace();
			}finally {
				try {
					inputStream.close();
					outputStream.close();
				}catch(IOException e) {}
			}
			
		}else{
			int r = bBiz.updatePost(vo);
			ModelAndView mav = new ModelAndView("board/result_update","result",r);
			return mav;
		}
		int r = bBiz.updatePostWithImg(vo);
		ModelAndView mav = new ModelAndView("board/result_update","result",r);
		return mav;
	}

}
