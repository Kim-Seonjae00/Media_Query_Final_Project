package com.icia.yogiseo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dao.AddressDAO;
import com.icia.yogiseo.dao.MemberDAO;
import com.icia.yogiseo.dao.OrdersDAO;
import com.icia.yogiseo.dto.AddressDTO;
import com.icia.yogiseo.dto.MemberDTO;

@Service
public class AddressService {
	
	@Autowired
	private AddressDAO addressDAO;
	
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
	
	//내 주소목록 조회
	public ModelAndView myAddressList(String mid) {
		mav = memberProfile(mid);
		
		List<AddressDTO> address = addressDAO.myAddressList(mid);
		MemberDTO member = memberDAO.memberView(mid);
		mav.addObject("member", member);
		mav.addObject("addressList", address);
		mav.setViewName("member/MyAddressList");
	
		return mav;
	}

	
	//회원 주소 작성화면 출력
	public ModelAndView addressForm(String mid) {
		mav = memberProfile(mid);
		
		mav.setViewName("member/AddressForm");
		
		return mav;
	}
	
	//주소 추가 처리
	public ModelAndView addressAdd(AddressDTO address) {
		mav = new ModelAndView();
		
		String mid = address.getMid();
		addressDAO.changeAll(mid);
		int addResult = addressDAO.addressAdd(address);
		if(addResult > 0) {
			mav.setViewName("redirect:/myaddresslist?mid="+address.getMid());
		}else {
			mav.setViewName("Fail");
		}
		
		return mav;
	}

	//대표 주소 변경
	public String addressPick(String mid, int anum) {
		addressDAO.changeAll(mid);
		int result = addressDAO.addressPick(anum);
		String resultMsg = null;
		if(result > 0) {
			resultMsg = "OK";
		}else {
			resultMsg = "NO";
		}
		
		return resultMsg;
	}

	//회원 주소 삭제
	public ModelAndView addressDelete(String mid, int anum) {
		mav = new ModelAndView();
		
		int deleteResult = addressDAO.addressDelete(anum);

		if(deleteResult > 0)
			mav.setViewName("redirect:/myaddresslist?mid="+mid);
		else
			mav.setViewName("Fail");
		
		return mav;
	}

	//회원 주소 개수 조회
	public String addressCount(String mid) {
		int countResult = addressDAO.addressCount(mid);
		String resultMsg = null;
		
		if(countResult < 3) {
			resultMsg = "OK";
		}else {
			resultMsg = "NO";
		}
		
		return resultMsg;
	}
}
