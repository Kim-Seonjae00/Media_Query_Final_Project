package com.icia.yogiseo.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dto.CartDTO;
import com.icia.yogiseo.dto.MenuDTO;
import com.icia.yogiseo.dto.SearchDTO;
import com.icia.yogiseo.dto.StoreDTO;
import com.icia.yogiseo.service.StoreService;

@Controller
public class StoreController {
	@Autowired
	private StoreService storeService;

	private ModelAndView mav;

	@Autowired
	private HttpSession session;

	// 업체 검색
	@RequestMapping(value = "/searchby", method = RequestMethod.GET)
	public ModelAndView searchBy(@ModelAttribute SearchDTO search) {
		mav = storeService.searchBy(search);

		return mav;
	}

	// 업체 리스트 출력
	@RequestMapping(value = "/storelist")
	public @ResponseBody List<StoreDTO> storeList(@ModelAttribute SearchDTO search) {
		List<StoreDTO> storeList = storeService.storeList(search);

		return storeList;
	}

	// 업체 상세
	@RequestMapping(value = "/storeview")
	public ModelAndView storeView(@ModelAttribute StoreDTO store) {
		mav = storeService.storeView(store);

		return mav;
	}

	// 업체 가입화면 출력
	@RequestMapping(value = "/storejoinform", method = RequestMethod.GET)
	public String storejoinform() {
		return "store/StoreJoinForm";
	}

	// 업체 가입 처리
	@RequestMapping(value = "/storejoin")
	public ModelAndView storeJoin(@ModelAttribute StoreDTO store) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		mav = storeService.storeJoin(store);

		return mav;
	}

	// 아이디 중복체크
	@RequestMapping(value = "/sidoverlap", method = RequestMethod.POST)
	public @ResponseBody String idOverlap(@RequestParam("id") String id) {
		String resultMsg = storeService.idOverlap(id);

		return resultMsg;
	}

	// 업체 로그인화면 출력
	@RequestMapping(value = "/storeloginform", method = RequestMethod.GET)
	public String storeloinform() {
		return "store/StoreLoginForm";
	}

	// 업체 로그인 처리
	@RequestMapping(value = "/storelogin")
	public ModelAndView storeLogin(@ModelAttribute StoreDTO store) {
		mav = storeService.storeLogin(store);

		return mav;
	}

	// 업체 마이페이지 출력
	@RequestMapping(value = "storepage")
	public ModelAndView storePage(@RequestParam("sid") String sid) {
		mav = storeService.storePage(sid);

		return mav;
	}

	// 업체 로그아웃 처리
	@RequestMapping(value = "/storelogout")
	public String storeLogout() {
		session.invalidate();

		return "store/StoreLoginForm";
	}

	// 업체 메뉴 리스트
	@RequestMapping(value = "/menulist")
	public ModelAndView storeMenuList(@RequestParam("sid") String sid) {
		mav = storeService.storeMenuList(sid);

		return mav;
	}

	// 업체 메뉴 추가 화면 이동
	@RequestMapping(value = "/menuaddform")
	public ModelAndView menuAddForm(@RequestParam("sid") String sid) {
		mav = storeService.storeProfile(sid);
		mav.setViewName("store/MenuAddForm");

		return mav;
	}

	// 메뉴 추가
	@RequestMapping(value = "/menuadd")
	public ModelAndView menuAdd(@ModelAttribute MenuDTO menu) throws IllegalStateException, IOException {
		mav = storeService.menuAdd(menu);

		return mav;
	}

	// 메뉴 삭제
	@RequestMapping(value = "/menudelete")
	public ModelAndView menuDelete(@RequestParam("menunum") int menunum, @RequestParam("sid") String sid) {
		mav = storeService.menuDelete(menunum, sid);

		return mav;
	}

	// 메뉴 수정 화면 이동
	@RequestMapping(value = "/menumodifyview")
	public ModelAndView menuModifyView(@RequestParam("menunum") int menunum) {
		mav = storeService.menuModifyView(menunum);

		return mav;
	}

	// 메뉴 수정 처리
	@RequestMapping(value = "/menumodify")
	public ModelAndView menuModifyView(@ModelAttribute MenuDTO menu) throws IllegalStateException, IOException {
		mav = storeService.menuModify(menu);

		return mav;
	}

	// 업체 페이지에서 리뷰 조회
	@RequestMapping(value = "/storereviewlist")
	public ModelAndView storeReviewList(@RequestParam("sid") String sid) {
		mav = storeService.storeReviewList(sid);
		return mav;
	}

	// 업체 음식점 등록 신청화면 이동
	@RequestMapping(value = "/storeconfirmform")
	public ModelAndView storeConfirmForm(@RequestParam("sid") String sid) {
		mav = storeService.storeConfirmForm(sid);

		return mav;
	}
	
	// 메뉴 검색
	@RequestMapping(value="/searchmenu")
	public ModelAndView searchMenu(@RequestParam("searchWord") String searchWord) {
		mav = storeService.searchMenu(searchWord);
		return mav;
	}

	// 업체 음식점 등록 신청 처리
	@RequestMapping(value = "/storeconfirm")
	public ModelAndView storeConfirm(@RequestParam("sid") String sid) {
		mav = storeService.storeConfirm(sid);

		return mav;
	}

	// 업체 정보 수정 화면 이동
	@RequestMapping(value = "/storemodifyform")
	public ModelAndView storeModifyForm(@RequestParam("sid") String sid) {
		mav = storeService.storeModifyForm(sid);

		return mav;
	}

	// 업체 수정 처리
	@RequestMapping(value = "/storemodify")
	public ModelAndView storeModify(@ModelAttribute StoreDTO store) throws IllegalStateException, IOException {
		mav = storeService.storeModify(store);

		return mav;
	}

	// 업체 탈퇴화면 이동
	@RequestMapping(value = "/storedeleteform")
	public ModelAndView storeDeleteForm(@RequestParam("sid") String sid) {
		mav = storeService.storeProfile(sid);
		mav.setViewName("store/StoreDeleteForm");

		return mav;
	}

	// 업체 탈퇴 처리
	@RequestMapping(value = "/storedelete")
	public ModelAndView storeDelete(@RequestParam("sid") String sid,
			@RequestParam("passwordcheck") String passwordcheck) {
		mav = storeService.storeDelete(sid, passwordcheck);
		return mav;
	}

	// 관리자 업체 목록 조회
	@RequestMapping(value = "/adminstorelist")
	public ModelAndView memberList(@RequestParam("loginId") String loginId) {
		mav = storeService.adminStoreList(loginId);

		return mav;
	}

	// 관리자 업체 상세 조회
	@RequestMapping(value = "/adminstoreview")
	public ModelAndView adminStoreView(@RequestParam("sid") String sid) {
		mav = storeService.adminStoreView(sid);
		return mav;
	}

	// 관리자 업체 삭제
	@RequestMapping(value = "/adminstoredelete")
	public ModelAndView adminStoreDelete(@RequestParam("sid") String sid, @RequestParam("loginId") String loginId) {
		mav = storeService.adminStoreDelete(sid, loginId);
		return mav;
	}

	// 관리자 업체 블랙리스트 조회
	@RequestMapping(value = "/storeblacklist")
	public ModelAndView storeBlackList(@RequestParam("loginId") String loginId) {
		mav = storeService.storeBlackList(loginId);
		return mav;
	}

	// 관리자 업체 블랙리스트 해제
	@RequestMapping(value = "/storeblacklistdelete")
	public ModelAndView storeBlackListDelete(@RequestParam("sid") String sid, @RequestParam("loginId") String loginId) {
		mav = storeService.storeBlackListDelete(sid, loginId);
		return mav;
	}

	// 관리자 업체 블랙리스트 추가
	@RequestMapping(value = "/storeblacklistadd")
	public ModelAndView storeBlackListAdd(@RequestParam("sid") String sid, @RequestParam("loginId") String loginId) {
		mav = storeService.storeBlackListAdd(sid, loginId);
		return mav;
	}

	// 관리자 음식점 신청 업체 리스트 조회
	@RequestMapping(value = "/storeaddlist")
	public ModelAndView storeAddList(@RequestParam("loginId") String loginId) {
		mav = storeService.storeAddList(loginId);
		return mav;
	}

	// 관리자 음식점 신청 업체 승인 처리
	@RequestMapping(value = "/storeaddconfirm")
	public ModelAndView storeAddConfirm(@RequestParam("sid") String sid, @RequestParam("loginId") String loginId) {
		mav = storeService.storeAddConfirm(sid, loginId);
		return mav;
	}

	// 관리자 음식점 신청 업제 거절 처리
	@RequestMapping(value = "/storeaddreject")
	public ModelAndView storeAddReject(@RequestParam("sid") String sid, @RequestParam("loginId") String loginId) {
		mav = storeService.storeAddConReject(sid, loginId);
		return mav;
	}

	// 업체 예약내역
	@RequestMapping(value = "/storebookinglist")
	public ModelAndView storeBookingList(@RequestParam("sid") String sid) {
		mav = storeService.storeBookingList(sid);

		return mav;
	}

	// 관리자 업체 맛집 카테고리 수정
	@RequestMapping(value = "/getmatcategory")
	public ModelAndView getMatCategory(@ModelAttribute StoreDTO store) {
		mav = storeService.getMatCategory(store);
		return mav;
	}
}
