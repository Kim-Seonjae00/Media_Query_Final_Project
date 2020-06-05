package com.icia.yogiseo.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dao.BookingDAO;
import com.icia.yogiseo.dao.MemberDAO;
import com.icia.yogiseo.dao.OrdersDAO;
import com.icia.yogiseo.dao.RecommentDAO;
import com.icia.yogiseo.dao.ReviewDAO;
import com.icia.yogiseo.dao.StoreDAO;
import com.icia.yogiseo.dto.BookingDTO;
import com.icia.yogiseo.dto.MemberDTO;
import com.icia.yogiseo.dto.MenuDTO;
import com.icia.yogiseo.dto.OrdersDTO;
import com.icia.yogiseo.dto.RecommentDTO;
import com.icia.yogiseo.dto.ReviewDTO;
import com.icia.yogiseo.dto.SearchDTO;
import com.icia.yogiseo.dto.StoreBlackListDTO;
import com.icia.yogiseo.dto.StoreDTO;

@Service
public class StoreService {

	@Autowired
	private StoreDAO storeDAO;
	@Autowired
	private ReviewDAO reviewDAO;
	@Autowired
	private OrdersDAO ordersDAO;
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private HttpSession session;
	@Autowired
	private BookingDAO bookingDAO;
	@Autowired
	private RecommentDAO recommentDAO;

	private ModelAndView mav;

	private static final int PAGE_LIMIT = 2;


	//음식점 검색처리
	public ModelAndView searchBy(SearchDTO search) {
		mav = new ModelAndView();
		int page = 1;
		if (search.getPage() != 0) {
			page = search.getPage();
		}

		int startRow = (page - 1) * PAGE_LIMIT + 1;
		int endRow = page * PAGE_LIMIT;

		search.setStartRow(startRow);
		search.setEndRow(endRow);

		switch(search.getScategory()) {
		case "한식" : search.setListname("KOREANLIST"); break;
		case "분식" : search.setListname("STREETLIST"); break;
		case "중식" : search.setListname("CHINALIST"); break;
		case "아시안/양식" : search.setListname("ASIANLIST"); break;
		case "치킨" : search.setListname("CHICKENLIST"); break;
		case "족발/보쌈" : search.setListname("PIGLIST"); break;
		case "일식/돈까스" : search.setListname("JAPANLIST"); break;
		case "피자" : search.setListname("PIZZALIST"); break;
		case "패스트푸드" : search.setListname("FASTLIST"); break;
		case "야식" : search.setListname("NIGHTLIST"); break;
		case "디저트" : search.setListname("DESERTLIST"); break;
		}

		List<StoreDTO> storeList = storeDAO.searchBy(search);
		search.setPage(page);

		mav.addObject("search", search);
		mav.addObject("storeList", storeList);
		mav.setViewName("store/StoreList");

		return mav;
	}

	//음식점 리스트 출력
	public List<StoreDTO> storeList(SearchDTO search) {
		int page = 1;
		if (search.getPage() != 0) {
			page = search.getPage();
		}
		int startRow = (page - 1) * PAGE_LIMIT + 1;
		int endRow = page * PAGE_LIMIT;

		search.setStartRow(startRow);
		search.setEndRow(endRow);

		switch(search.getScategory()) {
		case "한식" : search.setListname("KOREANLIST"); break;
		case "분식" : search.setListname("STREETLIST"); break;
		case "중식" : search.setListname("CHINALIST"); break;
		case "아시안/양식" : search.setListname("ASIANLIST"); break;
		case "치킨" : search.setListname("CHICKENLIST"); break;
		case "족발/보쌈" : search.setListname("PIGLIST"); break;
		case "일식/돈까스" : search.setListname("JAPANLIST"); break;
		case "피자" : search.setListname("PIZZALIST"); break;
		case "패스트푸드" : search.setListname("FASTLIST"); break;
		case "야식" : search.setListname("NIGHTLIST"); break;
		case "디저트" : search.setListname("DESERTLIST"); break;
		}

		List<StoreDTO> storeList = storeDAO.searchBy(search);

		search.setPage(page);

		return storeList;
	}

	//음식점 상세조회
	public ModelAndView storeView(StoreDTO store) {
		mav = new ModelAndView();
		String sid = store.getSid();
		List<MenuDTO> menuList = storeDAO.menuList(sid);
		StoreDTO store1 = storeDAO.storeView(sid);
		int reviewCount = reviewDAO.reviewCount(sid);
		float reviewRate = reviewDAO.reviewRate(sid);

		mav.addObject("menuList", menuList);
		mav.addObject("store", store1);
		mav.addObject("reviewCount", reviewCount);
		mav.addObject("reviewRate", reviewRate);
		mav.setViewName("store/StoreView");
		return mav;
	}

	//업체 회원가입
	public ModelAndView storeJoin(StoreDTO store) throws IllegalStateException, IOException {
		mav = new ModelAndView();

		MultipartFile simgFile = store.getSimgfile();
		String simg = simgFile.getOriginalFilename();

		String savePath = "C:\\Users\\4\\Desktop\\Development\\Source\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\Profile\\"
				+ simg;

		if (!simgFile.isEmpty()) {
			simgFile.transferTo(new File(savePath));
		}
		store.setSimg(simg);

		int joinResult = storeDAO.storeJoin(store);
		if (joinResult > 0) {
			reviewDAO.firstReviewWrite(store.getSid());

			mav.setViewName("store/StoreLoginForm");
		} else {
			mav.setViewName("Fail");
		}
		return mav;
	}

	//아이디 중복검사
	public String idOverlap(String id) {
		String checkResult = storeDAO.idOverlap(id);
		String resultMsg = null;

		if (checkResult == null) {
			resultMsg = "OK";
		} else {
			resultMsg = "NO";
		}

		return resultMsg;
	}

	//업체 로그인
	public ModelAndView storeLogin(StoreDTO store) {
		mav = new ModelAndView();
		String storeId = storeDAO.storeLogin(store);

		if (storeId != null) {
			session.setAttribute("storeId", storeId);
			store = storeDAO.storeView(storeId);

			mav.setViewName("redirect:/storepage?sid="+storeId);
		} else {
			mav.setViewName("Fail");
		}

		return mav;
	}

	//업체 마이페이지 이동
	public ModelAndView storePage(String sid) {
		mav = storeProfile(sid);

		List<String> onumList = ordersDAO.storeOnumList(sid);
		Map<String, List<OrdersDTO>> ordersMap = new HashMap<String, List<OrdersDTO>>();
		for(int i=0;i<onumList.size();i++) {
			List<OrdersDTO> ordersList = ordersDAO.storeOrdersList(onumList.get(i));
			if(onumList.get(i).equals(ordersList.get(0).getOnum())) {
				ordersMap.put(onumList.get(i), ordersList);
			}
		}

		mav.addObject("onumList",onumList);
		mav.addObject("ordersMap",ordersMap);
		mav.setViewName("store/StorePage");
		return mav;
	}

	//업체 메뉴 리스트 조회
	public ModelAndView storeMenuList(String sid) {
		mav = storeProfile(sid);

		List<MenuDTO> menuList = storeDAO.menuList(sid);

		mav.addObject("menuList", menuList);
		mav.setViewName("store/MenuList");
		return mav;
	}


	//업체 메뉴 추가
	public ModelAndView menuAdd(MenuDTO menu) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		MultipartFile menuimgFile = menu.getMenuimgfile();
		String menuimg = menuimgFile.getOriginalFilename();

		String savePath = "C:\\Users\\4\\Desktop\\Development\\Source\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\menuImage\\"
				+ menuimg;

		if (!menuimg.isEmpty()) {
			menuimgFile.transferTo(new File(savePath));
		}
		menu.setMenuimg(menuimg);
		int addResult = storeDAO.menuAdd(menu);
		if(addResult==1) {
			mav.setViewName("redirect:/menulist?sid="+menu.getSid());
		}

		return mav;
	}

	//업체 메뉴 삭제
	public ModelAndView menuDelete(int menunum, String sid) {
		mav = new ModelAndView();
		int delResult = storeDAO.menuDelete(menunum);
		if(delResult==1) {
			mav.setViewName("redirect:/menulist?sid="+sid);
		}
		return mav;
	}

	//업체 메뉴 수정 화면 이동
	public ModelAndView menuModifyView(int menunum) {
		mav = new ModelAndView();
		MenuDTO menu = storeDAO.menuView(menunum);
		String sid = menu.getSid();
		StoreDTO store = storeDAO.storeView(sid);
		mav = storeProfile(sid);
		mav.addObject("menu", menu);
		mav.addObject("store", store);
		mav.setViewName("store/MenuModify");
		return mav;
	}

	//업체 메뉴 수정 처리 
	public ModelAndView menuModify(MenuDTO menu) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		MultipartFile menuimgFile = menu.getMenuimgfile();
		String menuimg = menuimgFile.getOriginalFilename();

		String savePath = "C:\\Users\\4\\Desktop\\Development\\Source\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\menuImage\\"
				+ menuimg;

		if (!menuimg.isEmpty()) {
			menuimgFile.transferTo(new File(savePath));
		}else {
			menuimg = menu.getMenuimg();
		}

		menu.setMenuimg(menuimg);
		int modifyResult = storeDAO.menuModify(menu);
		if(modifyResult==1) {
			mav.setViewName("redirect:/menulist?sid="+menu.getSid());
		}
		return mav;
	}

	//업체 리뷰 리스트 조회
	public ModelAndView storeReviewList(String sid) {
		mav = storeProfile(sid);

		List<ReviewDTO> reviewList = storeDAO.reviewList(sid);
		List<RecommentDTO> recommentList = new ArrayList<RecommentDTO>();
		for(int i=0;i<reviewList.size();i++) {
			RecommentDTO recomment = recommentDAO.recommentGet(reviewList.get(i).getRnum());
			if(recomment != null) {
				recommentList.add(recomment);
			}
		}

		Map<Integer,RecommentDTO> recommentMap = new HashMap<Integer,RecommentDTO>(); 
		for(int i=0;i<recommentList.size();i++) {
			recommentMap.put(recommentList.get(i).getRnum(),recommentList.get(i));
		}

		mav.addObject("recommentMap", recommentMap);
		mav.addObject("reviewList", reviewList);
		mav.setViewName("store/StoreReviewList");
		return mav;
	}

	//음식점 등록신청 화면 이동
	public ModelAndView storeConfirmForm(String sid) {
		mav = storeProfile(sid);

		mav.setViewName("store/StoreConfirmForm");
		return mav;
	}

	//음식점 등록신청
	public ModelAndView storeConfirm(String sid) {
		mav = storeProfile(sid);


		int confirmResult = storeDAO.storeConfirm(sid);
		if(confirmResult == 1) {
			mav.setViewName("redirect:/storeconfirmform?sid="+sid);
		}
		return mav;
	}

	//업체 정보 수정화면 이동
	public ModelAndView storeModifyForm(String sid) {
		mav = storeProfile(sid);


		mav.setViewName("store/StoreModifyForm");
		return mav;
	}

	//업제 정보 수정
	public ModelAndView storeModify(StoreDTO store) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		MultipartFile sFile = store.getSimgfile();
		String simg = sFile.getOriginalFilename();

		String savePath = "C:\\Users\\4\\Desktop\\Development\\Source\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\Profile\\"
				+ simg;

		if (!simg.isEmpty()) {
			sFile.transferTo(new File(savePath));
		}else {
			simg = store.getSimg();
		}

		store.setSimg(simg);
		int modResult = storeDAO.storeModify(store);

		if(modResult==1) {
			mav.setViewName("redirect:/storepage?sid="+store.getSid());
		}

		return mav;
	}

	//업체 탈퇴
	public ModelAndView storeDelete(String sid, String passwordcheck) {
		mav = new ModelAndView();
		int deleteResult = 0;
		if(storeDAO.storeCheck(sid, passwordcheck) == 1) {		
			deleteResult = storeDAO.storeDelete(sid);
			session.invalidate();
		}
		mav.addObject("deleteResult", deleteResult);
		mav.setViewName("store/StoreDeleteResult");
		return mav ;
	}
	
	// 메뉴 검색
	public ModelAndView searchMenu(String searchWord) {
		mav = new ModelAndView();

		searchWord = "%"+searchWord+"%";
		List<String> sidList = storeDAO.sidList(searchWord);

		List<StoreDTO> searchStoreList = new ArrayList<StoreDTO>();
		if(sidList != null) {
			for(int i=0;i<sidList.size();i++) {
				String sid = sidList.get(i);
				searchStoreList.add(storeDAO.searchStoreList(sid));
				if(searchStoreList.get(i).getRunning() < 2) {
					searchStoreList.remove(i);
				}
			}
			if(searchStoreList != null) {
				if(searchStoreList.size() == 0) {
					searchStoreList = null;
				}
				mav.addObject("searchStoreList", searchStoreList);
				mav.setViewName("SearchMenuResult");		
			}
		}
		return mav;
	}

	// 관리자 업체 목록 조회
	public ModelAndView adminStoreList(String loginId) {
		mav = new ModelAndView();

		List<StoreDTO> storeList = new ArrayList<StoreDTO>();
		storeList = storeDAO.adminStoreList();
		MemberDTO profile = memberDAO.myProfile(loginId);

		mav.addObject("profile", profile);
		mav.addObject("storeList", storeList);
		mav.setViewName("admin/AdminStoreList");

		return mav;
	}

	// 관리자 업체 상세 조회
	public ModelAndView adminStoreView(String sid) {
		mav = new ModelAndView();

		StoreDTO storeView = storeDAO.adminStoreView(sid);

		// 관리자 업체 평점 조회
		double rrate = reviewDAO.storeRrate(sid);
		System.out.println("평점:"+rrate);

		mav.addObject("rrate", rrate);
		mav.addObject("storeView", storeView);
		mav.setViewName("admin/AdminStoreView");

		return mav;
	}

	// 관리자 업체 삭제
	public ModelAndView adminStoreDelete(String sid, String loginId) {
		mav = new ModelAndView();

		int deleteResult = storeDAO.storeDelete(sid);
		if(deleteResult == 1) {
			mav.setViewName("redirect:/adminstorelist?loginId="+loginId);
		} else {
			mav.setViewName("Fail");
		}

		return mav;
	}

	// 관리자 업체 블랙리스트 조회
	public ModelAndView storeBlackList(String loginId) {
		mav = new ModelAndView();

		List<StoreBlackListDTO> storeBlackList = new ArrayList<StoreBlackListDTO>();
		storeBlackList = storeDAO.storeBlackList();
		MemberDTO profile = memberDAO.myProfile(loginId);

		mav.addObject("profile", profile);
		mav.addObject("storeBlackList", storeBlackList);
		mav.setViewName("admin/StoreBlackList");

		return mav;
	}

	// 관리자 업체 블랙리스트 해제
	public ModelAndView storeBlackListDelete(String sid, String loginId) {
		mav = new ModelAndView();

		int modifyResult = storeDAO.storeBlackListModify(sid);
		int deleteResult = 0;

		if(modifyResult == 1) {
			deleteResult = storeDAO.storeBlackListDelete(sid);
			if(deleteResult == 1) {
				mav.setViewName("redirect:/storeblacklist?loginId="+loginId);
			} else {
				mav.setViewName("Fail");
			}
		} else {
			mav.setViewName("Fail");
		}

		return mav;
	}

	// 관리자 음식점 블랙리스트 추가 처리
	public ModelAndView storeBlackListAdd(String sid, String loginId) {
		mav = new ModelAndView();

		int insertResult = 0;
		int updateResult = storeDAO.storeBlackListUpdate(sid);

		if(updateResult == 1) {
			insertResult = storeDAO.storeBlackListAdd(sid);
			if(insertResult == 1) {
				mav.setViewName("redirect:/storeblacklist?loginId="+loginId);
			} else {
				mav.setViewName("Fail");
			}
		} else {
			mav.setViewName("Fail");
		}

		return mav;
	}


	// 관리자 음식점 신청 업체 리스트 조회
	public ModelAndView storeAddList(String loginId) {
		mav = new ModelAndView();

		List<StoreDTO> storeAddList = new ArrayList<StoreDTO>();
		storeAddList = storeDAO.storeAddList();
		MemberDTO profile = memberDAO.myProfile(loginId);

		mav.addObject("profile", profile);
		mav.addObject("storeAddList", storeAddList);
		mav.setViewName("admin/StoreAddList");

		return mav;
	}

	// 관리자 음식점 신청 업체 승인 처리
	public ModelAndView storeAddConfirm(String sid, String loginId) {
		mav = new ModelAndView();

		int updateResult = storeDAO.storeAddConfirm(sid);

		if(updateResult == 1) {
			mav.setViewName("redirect:/storeaddlist?loginId="+loginId);
		} else {
			mav.setViewName("Fail");
		}

		return mav;
	}

	// 관리자 음식점 신청 업체 거절 처리
	public ModelAndView storeAddConReject(String sid, String loginId) {
		mav = new ModelAndView();

		int updateResult = storeDAO.storeAddReject(sid);

		if(updateResult == 1) {
			mav.setViewName("redirect:/storeaddlist?loginId="+loginId);
		} else {
			mav.setViewName("Fail");
		}

		return mav;
	}

	//업체 프로필
	public ModelAndView storeProfile(String sid) {
		mav = new ModelAndView();

		StoreDTO store = storeDAO.storeView(sid);
		List<ReviewDTO> reviewList = reviewDAO.storeReviewList(sid);
		List<String> onumList = ordersDAO.storeOnumList(sid);

		int reviewCount = reviewList.size();
		int ordersCount = onumList.size();

		mav.addObject("store", store);
		mav.addObject("reviewCount", reviewCount);
		mav.addObject("ordersCount", ordersCount);
		return mav;
	}

	//업체 예약내역
	public ModelAndView storeBookingList(String sid) {
		mav = storeProfile(sid);

		List<BookingDTO>  bookingList = bookingDAO.storeBookingList(sid);

		mav.addObject("bookingList", bookingList);
		mav.setViewName("store/StoreBookingList");
		return mav;
	}
	// 관리자 맛집 카테고리 수정
	public ModelAndView getMatCategory(StoreDTO store) {
		mav = new ModelAndView();

		int updateResult = storeDAO.getMatCategory(store);
		String sid = store.getSid();
		if(updateResult>0) {
			mav.setViewName("redirect:/adminstoreview?sid="+sid);
		} else {
			mav.setViewName("Fail");
		}
		
		return mav;
	}
}
