package com.increpas.cls2.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;

import com.increpas.cls2.vo.*;

public class MemberDao {
	@Autowired
	SqlSessionTemplate sqlSession;
	
	public int getIdCnt(String sid) {
		return sqlSession.selectOne("mSQL.idCheck", sid);
	}
	
	// 로그인 데이터베이스 전담 조회 처리함수
	public int getLogin(MemberVO mVO) {
		return sqlSession.selectOne("mSQL.login", mVO);
	}
	/*
		참고 ]
			select 질의명령을 처리하는 마이바티스 함수
				selectOne()		: 질의명령의 실행 결과가 한행인 경우에 사용하는 함수
								
				selectList()	: 질의명령의 실행 결과가 여러행인 경우에 사용하는 함수
								==> 반환값이 List 타입이다.
				형식 ]
					
					selectOne("질의명령xml파일 namespace.질의명령id"[, 데이터])
	 */
	
	// 회원리스트조회 전담 처리함수
	public List getMembList() { // 이 리스트에는 MemberVO 들이 담겨있다.
		return sqlSession.selectList("mSQL.membList");
	}
	
	// 회원번호로 회원정보조회 전담 처리함수
	public MemberVO getMemberInfo(int mno) {
		return sqlSession.selectOne("mSQL.memberNoInfo", mno);
	}
	
	// 회원정보 입력 전담 처리함수
	public int addMember(MemberVO mVO) {
		return sqlSession.insert("mSQL.addMember", mVO);
	}
	
	// 내정보조회 전담 처리함수
	public MemberVO getMyInfo(String id) {
		return sqlSession.selectOne("mSQL.memberIdInfo", id);
	}
	
	// 성별 아바타리스트조회 전담 처리함수
	public List avtGenList(String gen) {
		return sqlSession.selectList("mSQL.avtGenList", gen);
	}
	
	// 내 정보 수정 전담 처리 함수
	public int updateInfo(MemberVO mVO) {
		return sqlSession.update("mSQL.editMyInfo", mVO);
	}
}
