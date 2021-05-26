package com.increpas.cls2.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;
import org.springframework.beans.factory.annotation.*;

import com.increpas.cls2.dao.*;
import com.increpas.cls2.vo.*;

/**
 * 	이 클래스는 방명록 관련 요청을 처리할 컨트롤러 클래스
 * @author	우병환
 * @since	2021.05.18
 * @version	v.1.0
 * @see
 * 			작업이력 ]
 * 				2021.05.18	- 우병환
 * 					작업 내용 : 클래스 생성
 *
 */
@Controller
@RequestMapping("/gBoard")
public class GuestBoard {
	@Autowired
	GBoardDao gDao;
	
	@RequestMapping("/gBoardList.cls")
	public ModelAndView gBoardList(ModelAndView mv, HttpSession session) {
		/*
			이 함수는 방명록 리스트 조회 페이지를 요청했을때
			해당 페이지를 응답해주는 요청 처리함수이다.
			
			이제까지는 회원관련 기능만 처리했어서
			회원관련 sql, dao 를 사용했었다.
			
			지금부터는 방명록 관련 요청처리를 해야하기 때문에
			방명록 dao, sql 파일이 만들어져야 하고
			이때 dao는 컨트롤러에서 자동의존주입을 해서 사용하기 때문에
			빈처리가 되어야겠다.
			
			할일 ]
				dao bean처리, 마이바티스 별칭 만들고, 질의명령 추가
		 */
		
		// 할일
		// 방명록 리스트 조회
		List list = gDao.getAllList();
		
		// 작성글 수 조회
		String sid = (String) session.getAttribute("SID");
		if(sid != null) {
			int cnt = gDao.getCount(sid);
			mv.addObject("CNT", cnt);
		}
		
		// view에 데이터 심고
		mv.addObject("LIST", list);
		//  뷰 부르고
		mv.setViewName("gBoard/gBoardList");
		
		return mv;
	}
	
	// 방명록 글쓰기 폼 보기 요청 처리함수
	@RequestMapping("/gBoardWrite.cls")
	public ModelAndView gBoardWrite(ModelAndView mv, HttpSession session, RedirectView rv) {
		// 이 기능은 로그인 한 회원(회원가입에 성고하고 )에 한해서만 사용할 수 있는 기능이므로
		// 따라서 로그인 체크를 해야겠다.
		
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		
		// 작성한 글 수 조회
		int cnt = gDao.getCount(sid);
		if(cnt != 0) {
			rv.setUrl("/cls2/gBoard/gBoardList.cls");
			mv.setView(rv);
			return mv;
		}
		
		BoardVO bVO = gDao.writerInfo(sid);
		mv.addObject("DATA", bVO);
		
		mv.setViewName("gBoard/gBoardWrite");
		return mv;
	}
	
	// 방명록 글 등록 요청 처리함수
	@RequestMapping("/gBoardWriteProc.cls")
	public ModelAndView addGBoard(BoardVO bVO, ModelAndView mv, HttpSession session, RedirectView rv) {
		// 할일
		// 1. 로그인 체크하고
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			// 로그인 안된 경우
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		// 2. 데이터베이스에 글 등록하고
		int cnt = gDao.addGBoard(bVO);
		// 3. 결과에 따라 처리해주고
		if(cnt != 1) {
			// 등록작업 실패
			rv.setUrl("/cls2/gBoard/gBoardWrite.cls");
		} else {
			rv.setUrl("/cls2/gBoard/gBoardList.cls");
		}
		
		mv.setView(rv);
		
		// 4. 데이터 반환하고 		
		return mv;
	}
}