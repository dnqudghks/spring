package com.increpas.cls2.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Test1 {
	@RequestMapping("/main.cls")
	public String getMain() {
		return "main";
	}
	
	@RequestMapping("/test02/test03.cls")
	public ModelAndView getMyName(ModelAndView mv) {
		// ModelAndView 에 데이터를 넣는 방법
		mv.addObject("DATA", "우병환");
		// ModelAndView 에 뷰를 넣는 방법
		mv.setViewName("test02/test03"); // 뷰를 forward 방식으로 부르는 방법
		return mv;
	}
	
}
