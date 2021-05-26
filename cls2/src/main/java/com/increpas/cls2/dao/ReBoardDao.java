package com.increpas.cls2.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;

import com.increpas.cls2.util.*;
import com.increpas.cls2.vo.*;

public class ReBoardDao {
	@Autowired
	SqlSessionTemplate sqlSession;
	
	// 총 게시물 갯수 조회 전담 처리함수
	public int getTotal() {
		return sqlSession.selectOne("reSQL.getTotal");
	}
	
	// 페이지 게시글 리스트 조회 전담 처리함수
	public List getRnoList(PageUtil page) {
		return sqlSession.selectList("reSQL.rnoList", page);
	}
	
	// 원글 등록 전담 처리함수
	public int addBoard(BoardVO bVO) {
		return sqlSession.insert("reSQL.addReBoard", bVO);
	}
	
	// 댓글 등록 전담 처리함수
	public int addReply(BoardVO bVO) {
		return sqlSession.insert("reSQL.addReply", bVO);
	}
	
	// 게시글 삭제 전담 처리함수
	public int reboardDel(int bno) {
		return sqlSession.delete("reSQL.reboardDel", bno);
	}
	
	// 게시글 수정데이터 조회 전담 처리함수
	public BoardVO getEditData(int bno) {
		return sqlSession.selectOne("reSQL.editReBoard", bno);
	}
	
	// 게시글 수정 처리 전담 처리함수
	public int editProc(BoardVO bVO) {
		return sqlSession.update("reSQL.editProc", bVO);
	}
}