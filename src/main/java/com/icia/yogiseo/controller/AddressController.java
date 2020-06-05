package com.icia.yogiseo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dto.AddressDTO;
import com.icia.yogiseo.service.AddressService;

@Controller
public class AddressController {

	@Autowired
	private AddressService addressService; 
	
	private ModelAndView mav;
	

	//회원주소목록 조회
	@RequestMapping(value="myaddresslist")
	public ModelAndView myAddressList(@RequestParam("mid") String mid) {
		mav = new ModelAndView();
		mav = addressService.myAddressList(mid);
		
		return mav;
	}
	
	//회원 주소 작성화면 출력
	@RequestMapping(value="addressform")
	public ModelAndView addressForm(@RequestParam("mid") String mid) {
		mav = new ModelAndView();
		mav = addressService.addressForm(mid);
		
		return mav;
	}
	
	
	//회원 주소 추가
	@RequestMapping(value="addressadd")
	public ModelAndView addressAdd(@ModelAttribute AddressDTO address) {
		mav = new ModelAndView();
		mav = addressService.addressAdd(address);
		
		return mav;
	}
	
	//대표 주소 변경
	@RequestMapping(value="/addresspick")
	public @ResponseBody String addresspick(@RequestParam("mid") String mid, @RequestParam("anum") int anum) {
		String resultMsg = addressService.addressPick(mid, anum);
		
		return resultMsg;
	}
	
	//회원 주소 삭제
	@RequestMapping(value="addressdelete")
	public ModelAndView addressDelete(@RequestParam("mid") String mid, @RequestParam("anum") int anum) {
		mav = new ModelAndView();
		mav = addressService.addressDelete(mid, anum);
		
		return mav;
	}
	
	
	//회원 주소 개수 조회
	@RequestMapping(value="/addresscount")
	public @ResponseBody String addressCount(@RequestParam("mid") String mid) {
		String resultMsg = addressService.addressCount(mid);

		return resultMsg;
	}
	
	
	
	
}
