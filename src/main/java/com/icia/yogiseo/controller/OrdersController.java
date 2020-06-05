package com.icia.yogiseo.controller;

import java.io.UnsupportedEncodingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dto.CartDTO;
import com.icia.yogiseo.dto.OrdersDTO;
import com.icia.yogiseo.service.OrdersService;

@Controller
public class OrdersController {
	@Autowired
	private OrdersService ordersService;
	
	
	private ModelAndView mav;
	
	//장바구니 추가
	@RequestMapping(value="/cartadd")
	public @ResponseBody String cartAdd(@ModelAttribute CartDTO cart) {
		String cartAddResult = ordersService.cartAdd(cart);
		
		return cartAddResult;
	}
	
	//장바구니 리스트 조회
	@RequestMapping(value="/cartlist")
	public ModelAndView cartList(@RequestParam("mid") String mid) {
		mav = ordersService.cartList(mid);
		
		return mav;
	}
	
	//장바구니 삭제
	@RequestMapping(value="/cartdelete")
	public ModelAndView cartDelete(@RequestParam("mid") String mid,@RequestParam("cnum") int cnum) {
		mav = ordersService.cartDelete(mid, cnum);
		
		return mav;
	}
	
	//결제 화면 이동
	@RequestMapping(value="/orderspayform")
	public ModelAndView orderPayForm(@RequestParam("mid") String mid,@RequestParam("ordersList") String ordersList, @RequestParam("sid") String sid) {
		mav = ordersService.ordersPayForm(mid, ordersList, sid);
		
		return mav;
	}
	
	//결제 처리
	@RequestMapping(value="/orderspay")
	public ModelAndView orderPay(@RequestParam("cnum") String cnum,@ModelAttribute OrdersDTO orders, @RequestParam("couponnum") int couponnum,@RequestParam("mpoint") int mpoint) throws UnsupportedEncodingException {
		mav = ordersService.ordersPay(cnum, orders, couponnum, mpoint);
				
		return mav;
	}
	
	//수량 증가 처리
	@RequestMapping(value="/updatecamount")
	public @ResponseBody String upadteCamount(@ModelAttribute CartDTO cart) {
		String result = ordersService.updateCamount(cart);
				
		return result;
	}
	
	// 회원 주문 내역 조회
	@RequestMapping(value="/myorderslist")
	public ModelAndView myOrdersList(@RequestParam("mid") String mid) {
		mav = ordersService.myOrdersList(mid);
		
		return mav;
	}
	
	//업체 주문 승낙
	@RequestMapping(value="/ordersconfirm")
	public @ResponseBody String ordersConfirm(@RequestParam("onum") String onum) {
		String confirmResult = ordersService.ordersConfirm(onum);
		
		return confirmResult;
	}
	
	//주문 취소
	@RequestMapping(value="/orderscancel")
	public ModelAndView ordersCancel(@RequestParam("onum") String onum, @RequestParam("mid") String mid) {
		mav = ordersService.ordersCancel(onum, mid);
		
		return mav;
	}
}
