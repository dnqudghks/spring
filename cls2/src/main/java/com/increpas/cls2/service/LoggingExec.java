package com.increpas.cls2.service;

import java.text.SimpleDateFormat;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.*;

import com.increpas.cls2.vo.MemberVO;

@Service
@Aspect
public class LoggingExec {
	
	private static Logger recordLog = LoggerFactory.getLogger(LoggingExec.class);
	
	@Pointcut("execution(* com.increpas.cls2.controller.Member.loginProc(..))")
	public void recordLogin() {
		System.out.println("###recordLogin() ####");
	}
	
	@After("recordLogin()")
	public boolean rec(JoinPoint join) {
		MemberVO mVO = (MemberVO)join.getArgs()[0];
		
		if(mVO.getCnt() == 1) {
			//정상적으로 로그인 된 경우
			recordLog.info(mVO.getId() + " ] 회원 로그인 ******");
		} 
		return true;
	}
}
