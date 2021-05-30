package com.increpas.cls2.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.*;
import org.springframework.web.servlet.view.RedirectView;

import com.increpas.cls2.dao.*;
import com.increpas.cls2.vo.*;
import com.increpas.cls2.util.*;

/**
 * 	이 클래스는 게시판 관련 요청 처리 컨트롤러 클래스
 * @author	전은석
 * @since	2021.05.18
 * @version	v.1.0
 * @see
 * 			작업이력 ]
 * 				2021.05.18 
 * 					- 담당자 	: 전은석
 * 					- 작업내용 	: 클래스 제작
 * 
 * 				2021.05.27
 * 					- 담당자	: 전은석
 * 					- 작업내용 	: 게시판 리스트보기 기능 구현
 *
 */

@Controller
@RequestMapping("/board")
public class Board {
	@Autowired
	BoardDao bDao;
	@Autowired
	FileUtil fUtil;
	
	/*
	 * 게시글 리스트 보기 요청 처리함수
	 */
	@RequestMapping("/board.cls")
	public ModelAndView boardList(PageUtil page, ModelAndView mv) {
		/*
			페이징 처리에 필요한 데이터
				현재페이지, 총게시글 수, 보여질 게시글 수, 이동가능한 페이지 수
				
			지금의 경우는 한페이지에 5개의 글이 보이도록 해주고,
			이동가능한 페이지수도 5개로 해주자.
		 */
		int total = bDao.getTotal();
		// 데이터 만들고
		page.setPage(page.getNowPage(), total, 5, 5);
		
		List list = bDao.boardList(page);
		for(Object o : list) {
			BoardVO bVO = (BoardVO) o;
			bVO.setSdate(bVO.getWdate());
		}
		
		// 데이터 전달하고
		mv.addObject("PAGE", page);
		mv.addObject("LIST", list);
		// 뷰 셋팅하고
		mv.setViewName("board/boardList");
		// 반환값 반환해주고
		return mv;
	}
	
	/*
	 * 게시글 상세보기 요청 처리함수
	 */
	@RequestMapping("/boardDetail.cls")
	public ModelAndView boardDetail(int bno, int nowPage, ModelAndView mv) {
		// 게시글정보 꺼내오고
		BoardVO data = bDao.boardDetail(bno);
		data.setSdate();
		// 첨부파일 리스트 꺼내오고
		List list = bDao.subFileList(bno);
		// 데이터 전달하고
		mv.addObject("DATA", data);
		mv.addObject("LIST", list);
		mv.addObject("nowPage", nowPage);
		// 뷰 부르고
		mv.setViewName("board/boardDetail");
		return mv;
	}
	
	/*
	 * 게시글 작성 폼보기 요청 처리함수
	 */
	@RequestMapping("/boardWrite.cls")
	public ModelAndView boardWrite(ModelAndView mv, HttpSession session, RedirectView rv) {
		// 할일
		// 1. 로그인 검사하고
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		// 2. 뷰 셋팅하고
		mv.setViewName("board/boardWrite");
		// 3. 반환값 반환하고
		return mv;
	}
	
	/*
	 * 게시글 등록 요청 처리함수
	 */
	@RequestMapping("/boardWriteProc.cls")
	public ModelAndView boardWriteProc(BoardVO bVO, ModelAndView mv, HttpSession session, RedirectView rv) {
		// 할일
		// 1. 로그인 검사하고
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		// 2. 작성자 회원번호 꺼내오고 ==> 서브질의로 처리하기로 한다.
		// 3. 게시글 데이터베이스 작업
		int cnt = bDao.addBoard(bVO);
		// 4. 첨부파일 작업하고
		ArrayList<FileVO> list = null;
		if(cnt == 1) {
			try {
				int count = 0;
				list = fUtil.saveProc(bVO.getFile(), bVO.getBno(), "/img/upload/");
				
				// list의 VO에 게시글번호 채워주고
				for(FileVO vo : list) {
					// 5. 첨부파일 데이터베이스 작업
					count = bDao.addFile(vo);
				}
				// 6. 결과에 따라서 처리해주고
				if(count == list.size()) {
					// 이 경우는 정상적으로 파일 정보를 모두 저장한 경우
				} else {
					// 데이터베이스 작업 도중 문제가 생긴경우
					// 일반적으로 트랜젝션 처리를 해줘야 한다.
				}
			} catch (Exception e) {}
			rv.setUrl("/cls2/board/board.cls");
		} else {
			rv.setUrl("/cls2/board/boardWrite.cls");
		}
		
		// 뷰 부르고
		mv.setView(rv);
		
		// 7. 반환값 반환해주고
		return mv;
	}
	
	/*
	 * 게시글 수정 폼보기 요청
	 */
	@RequestMapping("/boardEdit.cls")
	public ModelAndView boardEdit(BoardVO bVO, ModelAndView mv, 
									HttpSession session, RedirectView rv) {
		// 할일
		// 1. 세션 검사하고
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		// 2. 데이터 가져오고
		// 게시글데이터...
		bVO = bDao.boardDetail(bVO.getBno());
		// 첨부파일 데이터...
		List list = bDao.subFileList(bVO.getBno());
		// 3. 데이터전달하고
		mv.addObject("DATA", bVO);
		mv.addObject("LIST", list);
		// 4. 뷰 설정하고
		mv.setViewName("board/boardEdit");
		
		// 5. 반환값 반환하고
		return mv;
	}
	
	/*
	 * 첨부파일 삭제 요청 처리함수
	 */
	@RequestMapping("/boardImgDel.cls")
	@ResponseBody
	public HashMap<String, String> boardImgDel(int fno, HttpSession session) {
		HashMap<String, String> map = new HashMap<String, String>();
		// 할일
		// 1. 로그인 검사
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			map.put("result", "REDIRECT");
		}
		// 2. 데이터베이스작업
		int cnt = bDao.delSub(fno);
		// 3. 결과에 따라서 처리해주고
		if(cnt == 1) {
			map.put("result", "YES");
		} else {
			map.put("result", "NO");
		}
		// 4. 데이터 반환하고
		return map;
	}
	
	/*
	 * 게시글 삭제 요청 처리함수
	 */
	@RequestMapping("/boardDel.cls")
	public ModelAndView boardDel(int nowPage, int bno, ModelAndView mv,
									HttpSession session, RedirectView rv) {
		// 세션검사하고
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		// 데이터베이스 처리하고
		int cnt = bDao.boardDel(bno);
		// 결과에 다라서 뷰 설정하고
		if(cnt == 1) {
			// 삭제에 성공한 경우
			mv.addObject("PATH", "/cls2/board/board.cls");
		} else {
			// 삭제에 실패한 경우
			mv.addObject("PATH", "/cls2/board/boardEdit.cls");
			mv.addObject("BNO", bno);
		}
		
		mv.addObject("nowPage", nowPage);
		
		mv.setViewName("board/redirectView");
		// 반환해주고
		return mv;
	}
	
	/*
	 * 게시글 수정 요청 처리함수
	 */
	@RequestMapping("/boardEditProc.cls")
	public ModelAndView boardEditProc(BoardVO bVO, int nowPage, ModelAndView mv, 
											HttpSession session, RedirectView rv) {
		// 세션 검사하고
		String sid = (String) session.getAttribute("SID");
		if(sid == null) {
			rv.setUrl("/cls2/member/login.cls");
			mv.setView(rv);
			return mv;
		}
		
		mv.addObject("nowPage", nowPage);
		mv.addObject("BNO", bVO.getBno());
		// 게시글 수정 데이터베이스 처리
		if(bVO.getTitle() != null || bVO.getBody() != null) {
			int cnt = bDao.boardEdit(bVO);
			if(cnt != 1) {
				// 수정 작업에 실패한 경우
				mv.addObject("PATH", "/cls2/board/boardEdit.cls");
				return mv;
			}
		}
		
		if(bVO.getFile() != null) {
			// 이 경우는 첨부한 파일이 존재하는 경우
			ArrayList<FileVO> list = null;
			try {
				list = fUtil.saveProc(bVO.getFile(), bVO.getBno(), "/img/upload/");
				
				int count = 0;
				
				for(FileVO vo : list) {
					count += bDao.addFile(vo);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		mv.addObject("PATH", "/cls2/board/boardDetail.cls");
		mv.setViewName("board/redirectView");
		return mv;
	}
}