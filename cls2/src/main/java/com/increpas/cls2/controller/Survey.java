package com.increpas.cls2.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.increpas.cls2.dao.*;
import com.increpas.cls2.service.SurveyService;
import com.increpas.cls2.vo.*;

/**
 * 	이 클래스는 설문조사 관련 요청을 전담처리할 클래스
 * @author	우병환
 * @since	2021.06.01
 * @version v.1.0
 * @see
 * 			작업이력 ]
 * 					2021/06/01	-	담당자		: 우병환
 * 									작업내용	: 클래스 제작
 * 												  설문조사 리스트 요청 함수 제작
 *
 */

@Controller
@RequestMapping("/survey")
public class Survey {
	@Autowired
	SurveyDao sDao;
	@Autowired
	SurveyService sSrvc;
	
	/*
		진행중인 설문 리스트 요청 처리함수
	 */
	@RequestMapping("/surveyList.cls")
	public ModelAndView surveyList(ModelAndView mv) {
		// 데이터베이스 조회하고
		List list = sDao.getList();
		// 데이터 전달하고
		mv.addObject("LIST", list);
		// 뷰 설정
		mv.setViewName("survey/surveyList");
		return mv;
	}
	
	/*
	 * 설문조사 페이지 요청 처리함수
	 */
	@RequestMapping("/survey.cls")
	public ModelAndView surveyDetail(SurveyVO sVO, ModelAndView mv, HttpSession session, RedirectView rv) {
		// 할일
		// 설문에 참여했는지 카운트 가져오고
		System.out.println("******************** survey.cls 처리 ***************");
		int cnt = sDao.answerCnt(sVO);
		if(cnt == 1) {
			// 이미 설문에 참여한 경우
			mv.addObject("PATH", "/cls2/survey/surveyResult.cls");
			mv.addObject("TITLE", sVO.getTitle());
			mv.addObject("SINO", sVO.getSino());
			mv.setViewName("survey/redirectPage");
			
			return mv;
		}
		
		// 문항리스트 꺼내고
		ArrayList<SurveyVO> list = (ArrayList<SurveyVO>) sDao.questList(sVO.getSino());
		// 문항의 보기리스트 꺼내서 채워주고
		for(SurveyVO s : list) {
			int qno = s.getQno();
			ArrayList<SurveyVO> l = (ArrayList<SurveyVO>) sDao.exList(qno);
			s.setList(l);
		}
		
		// 데이터 전달하고
		mv.addObject("TITLE", sVO.getTitle());
		mv.addObject("LIST", list);
		mv.addObject("LEN", list.size());
		
		// 뷰 부르고
		mv.setViewName("survey/survey");
		return mv;
	}
	
	@RequestMapping("/surveyProc.cls")
	public ModelAndView surveyProc(SurveyVO sVO, ModelAndView mv, RedirectView rv, HttpSession session) {
		try{
			sSrvc.addSrvyService(sVO, rv, session);
		} catch(Exception e) {
			rv.setUrl("/cls2/survey/survey.cls");
			e.printStackTrace();
		}
		
		mv.setView(rv);
		return mv;
	}
	
	@RequestMapping(value = "/surveyResult.cls", params = { "title", "sino" }/* , method=RequestMethod.POST */)
	public ModelAndView surveyResult(SurveyVO sVO, ModelAndView mv) {
		// 할일
		// 문항리스트 꺼내고
		ArrayList<SurveyVO> list = (ArrayList<SurveyVO>) sDao.questList(sVO.getSino());
		// 문항의 보기결과 리스트 꺼내서 채워주고
		for(SurveyVO s : list) {
			ArrayList<SurveyVO> l = (ArrayList<SurveyVO>) sDao.getExResult(s);
			s.setList(l);
		}
		
		// 데이터 전달하고
		mv.addObject("TITLE", sVO.getTitle());
		mv.addObject("LIST", list);
		mv.addObject("LEN", list.size());
		
		mv.setViewName("survey/surveyResult");
		return mv;
	}
}