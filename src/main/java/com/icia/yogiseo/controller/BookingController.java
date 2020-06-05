package com.icia.yogiseo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dto.BookingDTO;
import com.icia.yogiseo.service.BookingService;

@Controller
public class BookingController {

	@Autowired
	private BookingService bookingService;
	
	private ModelAndView mav;
	
	//음식점 예약화면 출력
	@RequestMapping(value="/bookingform")
	public ModelAndView bookigForm(@RequestParam("sid") String sid) {
		mav = bookingService.bookingForm(sid);
		
		return mav;
	}
	
	//음식점 예약 처리
	@RequestMapping(value="booking")
	public ModelAndView booking(@ModelAttribute BookingDTO booking) {
		mav = bookingService.booking(booking);
		
		return mav;
	}
	
	//예약목록 조회
	@RequestMapping(value="mybookinglist")
	public ModelAndView myBookingList(@RequestParam("mid") String mid) {
		mav = bookingService.myBookigList(mid);
		
		return mav;
	}
	
	//예약 취소 처리
	@RequestMapping(value="bookingcancel")
	public @ResponseBody String bookingCancel(@RequestParam("bnum") int bnum) {
		String resultMsg = bookingService.bookingCancel(bnum);
		
		return resultMsg;
	}
	
	//예약 수정 데이터 출력
	@RequestMapping(value="bookingmodifyform")
	public ModelAndView bookingModifyForm(@RequestParam("bnum") int bnum, @RequestParam("mid") String mid) {
		mav = bookingService.bookingModifyForm(bnum, mid);
		
		return mav;
	}
	
	//예약 수정 처리
	@RequestMapping(value="bookingmodify")
	public ModelAndView bookingModify(@ModelAttribute BookingDTO booking, @RequestParam("mid") String mid) {
		mav = bookingService.bookingModify(booking, mid);
		
		return mav;
	}
	
	@RequestMapping(value="bookingconfirm")
	public @ResponseBody String bookingConfirm(@ModelAttribute BookingDTO booking) {
		String confirmResult = bookingService.bookingConfirm(booking);
		
		return confirmResult;
	}
		
		
}

