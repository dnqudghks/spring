package com.increpas.cls2.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.increpas.cls2.vo.MemberVO;

/**
 * 이 클래스는 스프링 수업의 회원관련된 요청 처리를 할 클래스
 * @author yujin
 * @since   2021.05.18
 * @version v.1.0
 */

@Controller // 이 클래스가 요청을 처리할 컨트롤러의 역할을 할 컨트롤러 클래스로 만들어주는 어노테이션
@RequestMapping("/member") 
// 이 클래스의 함수를 요청할 때 공통적으로 회원관련된 요청을 할 것이고 
// 그 때마다 앞에 붙여줄 경로는 컨트롤러에서 공통적으로 처리하기로 한다.
public class Member {
   
   @RequestMapping("/login.cls")
   public ModelAndView getLogin(HttpSession session, ModelAndView mv, RedirectView rv) {
      if(isLogin(session)) {
    	  // 이 경우는 이미 로그인이 되어있는 경우이고
    	  // 로그인 페이지를 부르면 안되는 경우이고
    	  // 따라서 메인페이지로 돌려보낸다.
    	  
    	  /*
    	   	참고 ]
    	   		스프링에서 redirect 방식으로 뷰를 처리하는 방법
    	   		
    	   			RedirectView 객체에
    	   			rv.setUrl("요청주소")
    	   			
    	   			ModelAndView 에
    	   			mv.setView(rv);
    	   			
    	   			
    	   */
         rv.setUrl("/cls2/");
         mv.setView(rv);
      }else {
         String view = "member/login";
         mv.setViewName(view);
      }
      
      return mv;
   }
   
   @RequestMapping("/loginProc.cls")
   public ModelAndView loginProc(/*String id, String pw,*/MemberVO mVO, ModelAndView mv,
                                             HttpSession session, RedirectView rv) {
      String view ="/cls2/";
      if(isLogin(session)) {
      }else {
         // 이 부분에서 로그인 처리
      }
      
      
      // 파라미터 데이터 출력
      /*
      System.out.println("***** prarameter id : " + id);
      System.out.println("***** prarameter pw : " + pw);
      */
      System.out.println("***** prarameter id : " + mVO.getId());
      System.out.println("***** prarameter pw : " + mVO.getPw());
      System.out.println("***** prarameter ano : " + mVO.getAno());
      System.out.println(mVO);
      rv.setUrl(view);
      
      mv.setView(rv);
      return mv;
   }
   
   public boolean isLogin(HttpSession session) {
      String sid = (String) session.getAttribute("SID");
      
      return (sid == null) ? false : true;
   }
}
