package com.icia.yogiseo.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.thread.AsyncConfig;
import com.icia.yogiseo.service.AsyncTaskService;

@Controller
public class ThreadController {

	@Resource(name="asyncTaskService")
	private AsyncTaskService asyncTaskService;
	
	@Resource(name="asyncConfig")
	private AsyncConfig asyncConfig;
	
	
	@RequestMapping(value = "/startorderscalculate", method = RequestMethod.POST)
	public ModelAndView startOrdersCalculate(@RequestParam("onum") String onum) {
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			//Task 실행가능 여부 확인
			if(asyncConfig.checkSampleTaskExecute()) {
				asyncTaskService.jobRunningInBackground(onum);
			}else {
				System.out.println("Thread 개수 초과");
			}
		} catch (Exception e) {
			System.out.println("Thread Err :: " + e.getMessage());
		}
		return mav;
	}
}
