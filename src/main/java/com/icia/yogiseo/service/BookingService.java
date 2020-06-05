package com.icia.yogiseo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dao.BookingDAO;
import com.icia.yogiseo.dao.MemberDAO;
import com.icia.yogiseo.dao.OrdersDAO;
import com.icia.yogiseo.dao.StoreDAO;
import com.icia.yogiseo.dto.BookingDTO;
import com.icia.yogiseo.dto.MemberDTO;
import com.icia.yogiseo.dto.StoreDTO;

@Service
public class BookingService {

	@Autowired
	private BookingDAO bookingDAO;
	
	@Autowired
	private StoreDAO storeDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private OrdersDAO ordersDAO;
	
	private ModelAndView mav;
	
	//회원마이페이지 기본 프로필 설정
	public ModelAndView memberProfile(String mid) {
		mav = new ModelAndView();
		
		MemberDTO member = memberDAO.memberView(mid);
		int count = memberDAO.couponCount(mid);
		int ordersCount = ordersDAO.ordersCount(mid); 
		
		mav.addObject("couponCount", count);
		mav.addObject("ordersCount", ordersCount);
		mav.addObject("member", member);
		
		return mav;
	}
	
	//음식점 예약화면 출력
	public ModelAndView bookingForm(String sid) {
		mav = new ModelAndView();
		StoreDTO store = storeDAO.storeView(sid);
		
		mav.addObject("store", store);
		mav.setViewName("store/BookingForm");
		
		return mav;
	}

	//음식점 예약 처리
	public ModelAndView booking(BookingDTO booking) {
		mav = new ModelAndView();
		
		int bookingResult = bookingDAO.booking(booking);
		StoreDTO store = storeDAO.storeView(booking.getSid());
		
		if(bookingResult > 0) {
			mav.addObject("store", store);
			mav.setViewName("store/BookingSuccess");
		}else {
			mav.setViewName("Fail");
		}
		
		return mav;
	}
	
	//예약 목록 조회
	public ModelAndView myBookigList(String mid) {
		mav = memberProfile(mid);
		List<BookingDTO> booking = bookingDAO.myBookingList(mid);
		
		mav.addObject("bookingList", booking);
		mav.setViewName("member/MyBookingList");
		
		return mav;
	}

	//예약 취소 처리
	public String bookingCancel(int bnum) {
		int cancelResult = bookingDAO.bookingCancel(bnum);
		String resultMsg = null;
		
		if(cancelResult > 0) {
			resultMsg = "OK";
		}else {
			resultMsg = "NO";
		}
		
		return resultMsg;
	}

	public ModelAndView bookingModifyForm(int bnum, String mid) {
		mav = memberProfile(mid);
		BookingDTO booking = bookingDAO.bookingView(bnum);
		
		mav.addObject("booking", booking);
		mav.setViewName("member/BookingModifyForm");
		return mav;
	}

	public ModelAndView bookingModify(BookingDTO booking, String mid) {
		mav = memberProfile(mid);
		int modifyResult = bookingDAO.bookingModify(booking);
		System.out.println("mid:"+mid);
		if(modifyResult > 0) {
			mav.setViewName("redirect:/mybookinglist?mid="+mid);
		}else {
			mav.setViewName("Fail");
		}
		
		return mav;
	}

	public String bookingConfirm(BookingDTO booking) {
		String confirmResult = "";
		bookingDAO.bookingConfirm(booking);
		if(booking.getBconfirm()==1) {
			confirmResult = "ok";
		}else {
			confirmResult = "no";
		}
		
		return confirmResult;
	}

}
