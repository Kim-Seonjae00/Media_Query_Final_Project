package com.icia.yogiseo.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dao.MemberDAO;
import com.icia.yogiseo.dao.VoucherDAO;
import com.icia.yogiseo.dto.MemberDTO;
import com.icia.yogiseo.dto.VoucherBuyDTO;
import com.icia.yogiseo.dto.VoucherDTO;

@Service
public class VoucherService {
	
	@Autowired
	private VoucherDAO voucherDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	private ModelAndView mav;
	

	// 바우처 등록 처리
	public ModelAndView voucherAdd(VoucherDTO voucher, String loginId) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		int insertResult = 0;
		
		for(int i=0;i<voucher.getVcount();i++) {
			// 바우처 DP사진
			MultipartFile vimgfile = voucher.getVimgfile();
			String vimg = vimgfile.getOriginalFilename();
			
			String savePath = "C:\\Users\\4\\Desktop\\Development\\Source\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\VoucherDP\\"+vimg;
			if(!vimgfile.isEmpty()) {
				vimgfile.transferTo(new File(savePath));
			}
			voucher.setVimg(vimg);
			
//			// 바우처 QR코드
//			MultipartFile vqrfile = voucher.getVqrfile();
//			String vqr = vqrfile.getOriginalFilename();
//			
//			String savePath1 = "C:\\Users\\10\\Desktop\\develporent\\souce\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\voucherQR\\"+vqr;
//			if(!vqrfile.isEmpty()) {
//				vqrfile.transferTo(new File(savePath1));
//			}
//			voucher.setVqr(vqr);
			
			Random ran = new Random();
			StringBuffer sb = new StringBuffer(); //문자열 생성타입의 StringBuffer sb변수 선언
			int num = 0;
			do {
			num = ran.nextInt(10);
		
			sb.append(Integer.toString(num)); //num값의 숫자를 문자형으로 강제변환 후 문자열을 생성함
			
			} while (sb.length() < 10);
			
			System.out.println("sbb:"+sb);
			
			voucher.setVnum(sb.toString());
			
			insertResult = voucherDAO.voucherAdd(voucher);
		}
		
		
		if(insertResult > 0) {
			mav.setViewName("redirect:/adminvoucherlist?loginId="+loginId);
		} else {
			mav.setViewName("Fail");
		}
		return mav;
	}

	// 관리자 바우처 리스트 조회
	public ModelAndView adminVoucherList(String loginId) {
		mav = new ModelAndView();
		
		List<VoucherDTO> voucherList = new ArrayList<VoucherDTO>();
		voucherList = voucherDAO.adminVoucherList();
		MemberDTO profile = memberDAO.myProfile(loginId);
		
		mav.addObject("profile", profile);
		mav.addObject("voucherList", voucherList);
		mav.setViewName("admin/AdminVoucherList");
		
		return mav;
	}

	// 바우처 등록 화면 이동
	public ModelAndView voucherAddForm(String loginId) {
		mav = new ModelAndView();
		
		MemberDTO profile = memberDAO.myProfile(loginId);
		
		mav.addObject("profile", profile);
		mav.setViewName("admin/VoucherAddForm");
		return mav;
	}

	// 관리자 바우처 삭제
	public ModelAndView voucherDelete(String vnum, String loginId) {
		mav = new ModelAndView();
		
		int deleteResult = voucherDAO.voucherDelete(vnum);
		if(deleteResult == 1) {
			mav.setViewName("redirect:/adminvoucherlist?loginId="+loginId);
		} else {
			mav.setViewName("Fail");
		}
		
		return mav;
	}

	// 회원 바우처 리스트 조회
	public ModelAndView voucherList(String loginId) {
		mav = new ModelAndView();
		
		List<VoucherDTO> voucherList = new ArrayList<VoucherDTO>();
		voucherList = voucherDAO.voucherList();
		MemberDTO profile = memberDAO.myProfile(loginId);
		
		mav.addObject("profile", profile);
		mav.addObject("voucherList", voucherList);
		mav.setViewName("VoucherList");
		
		return mav;
	}

	// 회원 바우처 상세보기
	public ModelAndView voucherView(String vname) {
		mav = new ModelAndView();
		
		VoucherDTO voucher = voucherDAO.voucherView(vname);
		
		mav.addObject("voucher", voucher);
		mav.setViewName("VoucherView");
		return mav;
	}

	// 회원 바우처 구매 화면 이동
	public ModelAndView voucherBuyForm(String vname, String loginId) {
		mav = new ModelAndView();
		
		VoucherDTO voucher = voucherDAO.voucherView(vname);
		MemberDTO member = memberDAO.myProfile(loginId);
		
		mav.addObject("voucher", voucher);
		mav.addObject("member", member);
		mav.setViewName("VoucherBuyForm");
		return mav;
	}

	// 회원 바우처 구매
	public ModelAndView voucherBuy(VoucherBuyDTO voucherBuy) {
		mav = new ModelAndView();
		String vname = voucherBuy.getVname();
		String vnum = voucherDAO.voucherSelect(vname);

		voucherBuy.setVnum(vnum);

		int deleteResult = 0;
		int insertResult = voucherDAO.voucherBuy(voucherBuy);

		if(insertResult > 0) {
			//deleteResult = voucherDAO.voucherDelete(vnum);
			if(true) {
				mav.addObject("voucherBuy", voucherBuy);
				mav.setViewName("redirect:/myvoucherlist?mid="+voucherBuy.getMid());
			} else {
				mav.setViewName("Fail");
			}
		} else {
			mav.setViewName("Fail");
		}
		return mav;
	}

	//회원마이페이지 기본 프로필 설정
	public ModelAndView memberProfile(String mid) {
		mav = new ModelAndView();

		MemberDTO member = memberDAO.memberView(mid);
		int count = memberDAO.couponCount(mid);

		mav.addObject("couponCount", count);
		mav.addObject("member", member);

		return mav;
	}

	//회원 바우처 구매내역 조회
	public ModelAndView myVoucherList(String mid) {
		mav = memberProfile(mid);

		List<VoucherDTO> voucher = voucherDAO.myVoucherList(mid);
		mav.addObject("voucherList", voucher);
		mav.setViewName("member/MyVoucherList");

		return mav;
	}

	//회원 바우처 상세 조회
	public ModelAndView myVoucherView(String vnum, String mid) {
		mav = memberProfile(mid);

		VoucherBuyDTO voucherBuy = voucherDAO.myVoucherView(vnum);

		mav.addObject("voucher", voucherBuy);
		mav.setViewName("member/MyVoucherView");

		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
