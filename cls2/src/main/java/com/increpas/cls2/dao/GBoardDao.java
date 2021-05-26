package com.increpas.cls2.dao;

import java.util.List;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;

import com.increpas.cls2.vo.*;

public class GBoardDao {
	@Autowired
	SqlSessionTemplate sqlSession;
	
	// 방명록 게시글 리스트 조회 전담 처리함수
	public List getAllList() {
		return sqlSession.selectList("gSQL.allList");
	}
	
	// 방명록 작성글 갯수 조회 전담 처리함수
	public int getCount(String id) {
		return sqlSession.selectOne("gSQL.getCount", id);
	}
	
	// 작성자 정보조회 전담 처리함수
	public BoardVO writerInfo(String id) {
		return sqlSession.selectOne("gSQL.writerInfo", id);
	}
	
	// 방명록 등록 전담 처리함수
	public int addGBoard(BoardVO bVO) {
		return sqlSession.insert("gSQL.addGBoard", bVO);
	}
}