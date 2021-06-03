package com.increpas.cls2.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.increpas.cls2.dao.SurveyDao;

@Controller
public class Test1 {
	@Autowired
	SurveyDao sDao;
	
	@RequestMapping("/main.cls")
	public ModelAndView getMain(ModelAndView mv) {
		
		int cnt = 0 ;
		cnt = sDao.getPCount();
		mv.addObject("SCOUNT", cnt);
		
		mv.setViewName("main");
		return mv;
	}

	@RequestMapping("/test02/test03.cls")
	public ModelAndView getMyName(ModelAndView mv) {
		// ModelAndView 에 데이터를 넣는 방법
		mv.addObject("DATA", "전은석");
		// ModelAndView 에 뷰를 넣는 방법
		mv.setViewName("test02/test03"); // 뷰를 foward 방식으로 부르는 방법
		return mv;
	}
}