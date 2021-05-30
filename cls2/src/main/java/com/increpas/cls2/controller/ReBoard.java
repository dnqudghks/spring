package com.increpas.cls2.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.view.*;

import com.increpas.cls2.dao.*;
import com.increpas.cls2.vo.*;
import com.increpas.cls2.util.*;

/**
 * 	이 클래스는 댓글 게시판 관련 요청 처리 컨트롤러 클래스
 * @author	전은석
 * @since	2021.05.18
 * @version	v.1.0
 * @see
 * 			작업이력 ]
 * 				2021.05.18 
 * 					- 담당자 	: 전은석
 * 					- 작업내용 	: 클래스 제작
 *
 */

@Controller
@RequestMapping("/reBoard")
public class ReBoard {
	@Autowired
	ReBoardDao reDao;
	@Autowired
	GBoardDao gDao;
	
	/*
		게시글 리스트 폼보기 요청 처리함수
	 */
	@RequestMapping("/reBoardList.cls")
	public ModelAndView getList(PageUtil page, ModelAndView mv) {
		int nowPage = page.getNowPage();
		if(nowPage == 0) {
			nowPage = 1;
		}
		
		int total = reDao.getTotal();
		
 		// PageUtil 셋팅
		page.setPage(nowPage, total, 3, 3);
		
		// 리스트 조회
		List list = reDao.getRnoList(page);
		
		// 데이터 전달하고
		mv.addObject("LIST", list);
		mv.addObject("PAGE", page);
		
		// 뷰 부르고
		mv.setViewName("reBoard/reBoardList");
		
		return mv;
	}
	
	// 게시글 작성폼 보기 요청 처리함수
	@RequestMapping("/reBoardWrite.cls")
	public ModelAndView reBoardWrite(ModelAndView mv, HttpSession session, RedirectView rv) {
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
		}
		
		BoardVO bVO = gDao.writerInfo(sid);
		
		// 데이터 전달하고
		mv.addObject("DATA", bVO);
		// 뷰 부르고
		mv.setViewName("reBoard/reBoardWrite");
		return mv;
	}
	
	// 게시글 등록요청 전담 처리함수
	@RequestMapping("/reBoardWriteProc.cls")
	public ModelAndView reBoardWriteProc(BoardVO bVO, ModelAndView mv, 
											HttpSession session, RedirectView rv) {
		/*
			스프링에서 VO를 매개변수로 선언하면
			뷰에서 전달되는 파라미터의 키값에 해당하는 
			VO의 변수를 찾아서 자동으로 넘겨지는 파라미터를 VO에
			스프링이 채워준다.
		 */
		
		// 세션검사하고
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		
		// 데이터베이스에 데이터 입력한다.
		int cnt = reDao.addBoard(bVO);
		if(cnt == 1) {
			// 성공한 경우
			rv.setUrl("/cls2/reBoard/reBoardList.cls");
		} else {
			rv.setUrl("/cls2/reBoard/reBoardWrite.cls");
		}
		
		mv.setView(rv);
		return mv;
	}
	
	// 댓글 달기 폼보기 요청 처리함수
	@RequestMapping(value="/reBoardReply.cls", method=RequestMethod.POST)
	public ModelAndView reBoardReply(BoardVO bVO, int nowPage, ModelAndView mv, 
											HttpSession session, RedirectView rv ) {
		
		// 할일 
		// 1. 세션 검사하고
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		
		int upno = bVO.getUpno();
		String title = bVO.getTitle();
		
		// 2. 회원정보 가져오고
		BoardVO data = gDao.writerInfo(sid);
		// ==> 이 bVO에는 회원번호와 아바타저장이름만 기억되어있다.
		data.setUpno(upno);
		data.setTitle(title);
		
		// 3. 데이터 뷰에 전달하고
		mv.addObject("DATA", data);
		mv.addObject("nowPage", nowPage);
		// 4. 뷰 부르고
		mv.setViewName("reBoard/reBoardReply");
		// 5. 반환값 반환하고
		return mv;
	}
	
	// 댓글 등록 요청
	@RequestMapping("/reBoardReplyProc.cls")
	public ModelAndView reBoardReplyProc(int nowPage, BoardVO bVO, ModelAndView mv, HttpSession session, RedirectView rv) {
		// 할일
		// 1. 로그인체큰
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		
		// 데이터베이스 작업하고
		int cnt = reDao.addReply(bVO);
		
		// 결과에 따라 처리하고
		if(cnt == 1) {
			// 등록에 성공한 경우
			rv.setUrl("/cls2/reBoard/reBoardList.cls?nowPage=" + nowPage);
		} else {
			// 등록에 실패한 경우
			rv.setUrl("/cls2/reBoard/reBoardReply.cls");
		}
		mv.setView(rv);
		
		return mv;
	}
	
	// 게시글 삭제 요청 처리 함수
	@RequestMapping("/reBoardDel.cls")
	public ModelAndView reBoardDel(int bno, int nowPage, 
							ModelAndView mv, HttpSession session, RedirectView rv) {
		// 할일
		// 1. 로그인 검사하고
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		String view = "reBoard/redirectView";
		// 2. 데이터베이스 작업하고
		int cnt = reDao.reboardDel(bno);
		// 3. 결과에 따라서 처리하고(데이터 + 뷰)
		if(cnt == 0) {
			// 작업에 실패한 경우
			mv.addObject("MSG", "** 삭제 작업에 실패했습니다. **");
		} else {
			// 삭제처리작업에 성공한 경우
			mv.addObject("MSG", "[ " + cnt + " ] 개의 게시물을 삭제했습니다.");
		}
		
		mv.addObject("nowPage", nowPage);
		mv.addObject("PATH", "/cls2/reBoard/reBoardList.cls");
		mv.setViewName(view);
		// 4. 반환값 반환하고
		return mv;
	}
	
	// 게시글 수정 폼보기 요청
	@RequestMapping("/reBoardEdit.cls")
	public ModelAndView reBoardEdit(int bno, int nowPage, ModelAndView mv, 
									HttpSession session, RedirectView rv) {
		// 할일
		// 1. 로그인 검사
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		// 2. 데이터베이스조회
		BoardVO bVO = reDao.getEditData(bno);
		
		// 3. 데이터 전달
		mv.addObject("DATA", bVO);
		mv.addObject("TBODY", bVO.getBody().replaceAll("\r\n", " "));
		System.out.println("^^^^^^^^^^^ " + bVO.getBody().replaceAll("\r\n", " "));
		mv.addObject("nowPage", nowPage);
		// 4. 뷰 부르고
		mv.setViewName("reBoard/reBoardEdit");
		
		// 5. 반환값 반환하고
		return mv;
	}
	
	// 게시글 수정 처리 요청 
	@RequestMapping("/reBoardEditProc.cls")
	public ModelAndView reBoardEditProc(int nowPage, BoardVO bVO, ModelAndView mv, HttpSession session, RedirectView rv) {
		
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		
		int cnt = reDao.editProc(bVO);
		if(cnt != 1) {
			mv.addObject("MSG", "- 수정 처리 실패 -");
		} else {
			mv.addObject("MSG", "*** " + bVO.getBno() + " ] 번글 수정 처리 성공 ***");
		}
		
		mv.addObject("nowPage", nowPage);
		mv.addObject("PATH", "/cls2/reBoard/reBoardList.cls");
		mv.setViewName("reBoard/redirectView");
		return mv;
	}
}