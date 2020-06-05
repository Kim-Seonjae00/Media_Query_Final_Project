package com.icia.yogiseo.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dto.VoucherBuyDTO;
import com.icia.yogiseo.dto.VoucherDTO;
import com.icia.yogiseo.service.VoucherService;

@Controller
public class VoucherController {
	
	@Autowired
	private VoucherService voucherService; 
	
	private ModelAndView mav;

	// 관리자 바우처 등록 화면 이동
	@RequestMapping(value="/voucheraddform")
	public ModelAndView voucherAddForm(@RequestParam("loginId") String loginId) {
		mav = voucherService.voucherAddForm(loginId);
		return mav;
	}
	
	// 관리자 바우처 등록 처리
	@RequestMapping(value="/voucheradd")
	public ModelAndView voucherAdd(@ModelAttribute VoucherDTO voucher, @RequestParam("loginId") String loginId) throws IllegalStateException, IOException {
		mav = voucherService.voucherAdd(voucher, loginId);
		return mav;
	}
	
	// 관리자 페이지에서 바우처 리스트 조회
	@RequestMapping(value="/adminvoucherlist")
	public ModelAndView adminVoucherList(@RequestParam("loginId") String loginId) {
		mav = voucherService.adminVoucherList(loginId);
		return mav;
	}
	
	// 관리자 바우처 삭제
	@RequestMapping(value="/voucherdelete")
	public ModelAndView voucherDelete(@RequestParam("vnum") String vnum, @RequestParam("loginId") String loginId) {
		mav = voucherService.voucherDelete(vnum,loginId);
		return mav;
	}
	
	// 회원 바우처 리스트 조회
	@RequestMapping(value="/voucherlist")
	public ModelAndView voucherList(@RequestParam("loginId") String loginId) {
		mav = voucherService.voucherList(loginId);
		return mav;
	}
	
	// 회원 바우처 상세보기
	@RequestMapping(value="/voucherview")
	public ModelAndView voucherView(@RequestParam("vname") String vname) {
		mav = voucherService.voucherView(vname);
		return mav;
	}
	
	// 바우처 구매 화면 이동
	@RequestMapping(value="/voucherbuyform")
	public ModelAndView voucherBuyForm(@RequestParam("vname") String vname, @RequestParam("loginId") String loginId) {
		mav = voucherService.voucherBuyForm(vname, loginId);
		return mav;
	}
	
	// 회원 바우처 구매
	@RequestMapping(value="/voucherbuy")
	public ModelAndView voucherBuy(@ModelAttribute VoucherBuyDTO voucherBuy) {
		mav = voucherService.voucherBuy(voucherBuy);
		return mav;
	}
	
	//회원 바우처 구매내역 조회
	@RequestMapping(value="/myvoucherlist")
	public ModelAndView myVoucherList(@RequestParam("mid") String mid) {
		mav = voucherService.myVoucherList(mid);

		return mav;
	}

	//회원 바우처 상세 조회
	@RequestMapping(value="/myvoucherview")
	public ModelAndView myVoucherView(@RequestParam("vnum") String vnum, @RequestParam("mid") String mid) {
		mav = voucherService.myVoucherView(vnum, mid);

		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
