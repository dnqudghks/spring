package com.increpas.cls2.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.view.RedirectView;

import com.increpas.cls2.dao.*;
import com.increpas.cls2.util.*;
import com.increpas.cls2.vo.*;

public class BoardService {
	@Autowired
	BoardDao bDao;
	@Autowired
	FileUtil fUtil;
/*
	트랜젝션 처리에 사용할 함수는
		@Transactional
	이라는 어노테이션을 붙여주기만 하면
	함수 내부의 데이터베이스 작업들이 트랜젝션 처리가 된다.
 */
	// 게시글 등록 서비스 함수
	@Transactional
	public boolean insertBoard(BoardVO bVO, RedirectView rv) {
		// 반환값 변수
		boolean bool = false;
		rv.setUrl("/cls2/board/boardWrite.cls");
		
		int cnt = bDao.addBoard(bVO);
		// 4. 첨부파일 작업하고
		ArrayList<FileVO> list = null;
		if(cnt == 1) {
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
			rv.setUrl("/cls2/board/board.cls");
			bool = true;
		}
		
		return bool;
	}
	
	
}