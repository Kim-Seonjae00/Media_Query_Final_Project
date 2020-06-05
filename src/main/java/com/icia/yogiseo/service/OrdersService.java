package com.icia.yogiseo.service;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dao.AddressDAO;
import com.icia.yogiseo.dao.CartDAO;
import com.icia.yogiseo.dao.MemberDAO;
import com.icia.yogiseo.dao.MessageDAO;
import com.icia.yogiseo.dao.OrdersDAO;
import com.icia.yogiseo.dao.RecommendDAO;
import com.icia.yogiseo.dao.ReviewDAO;
import com.icia.yogiseo.dao.StoreDAO;
import com.icia.yogiseo.dto.AddressDTO;
import com.icia.yogiseo.dto.CartDTO;
import com.icia.yogiseo.dto.CouponDTO;
import com.icia.yogiseo.dto.MemberDTO;
import com.icia.yogiseo.dto.MenuDTO;
import com.icia.yogiseo.dto.MessageDTO;
import com.icia.yogiseo.dto.OrdersDTO;
import com.icia.yogiseo.dto.ReviewDTO;
import com.icia.yogiseo.dto.StoreDTO;

@Service
public class OrdersService {
	@Autowired
	private CartDAO cartDAO;
	
	@Autowired
	private AddressDAO addressDAO;
	
	@Autowired
	private StoreDAO storeDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private OrdersDAO ordersDAO;
	
	@Autowired
	private RecommendDAO recommendDAO;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ReviewDAO reviewDAO;
	
	@Autowired
	private MessageDAO messageDAO;
	
	private ModelAndView mav;

	//장바구니 추가
	public String cartAdd(CartDTO cart) {
		System.out.println(cart);
		int cartCheck = cartDAO.cartCheck(cart);
		CartDTO checkedCart = cartDAO.menuCheck(cart);
		String cartAddResult = null;
		
		if(cartCheck>0) {
			cartAddResult="overlap";
		}else {
			if(checkedCart != null) {
				cart.setCnum(checkedCart.getCnum());
				cartAddResult = cartDAO.cartUpdate(cart);
			}else {
				cartAddResult = cartDAO.cartAdd(cart);
			}
		}
		return cartAddResult;
	}

	//장바구니 리스트 조회
	public ModelAndView cartList(String mid) {
		mav = memberService.memberProfile(mid);
		
		List<CartDTO> cartList = cartDAO.cartList(mid);
		HashMap<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
		for(int i=0;i<cartList.size();i++) {
			int menunum = cartList.get(i).getMenunum();
			MenuDTO menu = storeDAO.menuView(menunum);
			menuMap.put(menunum, menu);
		}
		
		mav.addObject("menuMap", menuMap);
		mav.addObject("cartList", cartList);
		mav.setViewName("member/CartList");
		return mav;
	}

	//장바구니 삭제
	public ModelAndView cartDelete(String mid, int cnum) {
		mav = new ModelAndView();
		
		int deleteResult = cartDAO.cartDelete(cnum);
		if(deleteResult == 1) {
			mav.setViewName("redirect:/cartlist?mid="+mid);
		}
		return mav;
	}

	//결제화면 이동
	public ModelAndView ordersPayForm(String mid, String ordersList, String sid) {
		mav = memberService.memberProfile(mid);
		String[] orders =  null;
		List<CartDTO> cartList = new ArrayList<CartDTO>();
		int menutime = 0;
		orders = ordersList.split(" ");
		for(int i=0;i<orders.length;i++) {
			int cnum = Integer.parseInt(orders[i]); 
			CartDTO cart = cartDAO.cartGet(cnum);
			cartList.add(cart);
		}
		
		HashMap<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
		for(int i=0;i<cartList.size();i++) {
			int menunum = cartList.get(i).getMenunum();
			MenuDTO menu = storeDAO.menuView(menunum);
			menuMap.put(menunum, menu);
			if(menutime<menu.getMenutime()) {
				menutime = menu.getMenutime();
			}
		}
		
		List<AddressDTO> addressList = addressDAO.myAddressList(mid);
		List<CouponDTO> couponList = memberDAO.couponList(mid);
		
		
		
		StoreDTO store = storeDAO.storeView(sid);
		String saddress = store.getSadrs1();
		
		mav.addObject("menutime", menutime);
		mav.addObject("saddress", saddress);
		mav.addObject("couponList", couponList);
		mav.addObject("addressList", addressList);
		mav.addObject("menuMap", menuMap);
		mav.addObject("cartList",cartList);
		mav.setViewName("member/OrdersPayForm");
		return mav;
	}

	//결제처리
	public ModelAndView ordersPay(String cnum, OrdersDTO orders, int couponnum, int minusPoint) throws UnsupportedEncodingException {
		mav = new ModelAndView();
		String[] cnums = cnum.split(" ");
		String mid = null;
		int maxTime = 0;
		memberDAO.couponDelete(couponnum);
		List<String> mainList = recommendDAO.mainList();		
		String mainmenu = null;
		boolean hmenucheck=true;
		
		for(int i=0;i<cnums.length;i++) {
			int cnum1 = Integer.parseInt(cnums[i]);
			CartDTO cart = cartDAO.cartGet(cnum1);
			mid = cart.getMid();
			String sid = cart.getSid();
			String storename = cart.getStorename();
			String menuname = cart.getMenuname();
			int menunum = cart.getMenunum();
			int menuprice = cart.getMenuprice();
			int camount = cart.getCamount();
			List<OrdersDTO> ordersList = ordersDAO.checkFirstOrder(mid);
			if(ordersList.isEmpty()) {
				memberDAO.firstCouponAdd(mid);//첫 구매 시 쿠폰제공
			}
			MenuDTO menu = storeDAO.menuView(menunum);
			if(maxTime < menu.getMenutime()) {
				maxTime = menu.getMenutime();
			}
			
			menu.setMenunum(menunum);
			menu.setMenuhit(camount);
			storeDAO.updateMenuHit(menu);
			
			orders.setMid(mid);
			orders.setSid(sid);
			orders.setMenuname(menuname);
			orders.setStorename(storename);
			orders.setMenunum(menunum);
			orders.setMenuprice(menuprice);
			orders.setCamount(camount);
			orders.setOstatus("확인중");
			orders.setOtime(orders.getOtime()+maxTime);
			if(i==0) {
				StoreDTO store = new StoreDTO();
				store.setSid(sid);
				store.setSales(menuprice);
				storeDAO.updateStoreSales(store);
				
				MessageDTO message = new MessageDTO();
				String mcontents = "";
				for(int j=0;j<cnums.length;j++) {
					CartDTO cart1 = cartDAO.cartGet(Integer.parseInt(cnums[j]));
					if(j==cnums.length-1) {
						mcontents += cart1.getMenuname();	
					}else {
						mcontents += cart1.getMenuname()+", ";
					}
				}
				message.setMcontents(mid+"님이 "+mcontents+"를 주문하셨습니다.");
				message.setMreceiver(sid);
				message.setMsender(mid);
				messageDAO.sendOrdersPay(message);
				
				if(cnums.length==1) {
					message.setMcontents(menuname+"이 정상적으로 주문되었습니다.");
				}else {
					message.setMcontents(menuname+"외 "+(cnums.length-1)+"건이 정상적으로 주문되었습니다.");
				}
				
				message.setMreceiver(mid);
				message.setMsender(sid);
				messageDAO.sendOrdersPay(message);
			}
			
			if(ordersDAO.ordersPay(orders)==1) { //결제처리
				cartDAO.cartDelete(cnum1); //결제성공 시 장바구니에서 해당 상품 삭제 
			}
			
			
			if(hmenucheck) { //꿀조합 추천 메뉴 선정
				for(int j=0;j<mainList.size();j++) {
					if(menuname.contains(mainList.get(j))) {
						mainmenu = "%"+mainList.get(j)+"%";
						hmenucheck = false;
						break;
					} else {
						mainmenu = "기본";
					}
				}
			}
		}
		
		MemberDTO member = memberDAO.memberView(mid);
		
		int plusPoint = 0; 
		switch (member.getMgrade()) {//회원등급에 따른 포인트 적립
			case "BRONZE": plusPoint = (int)Math.round(orders.getOtotalprice()*0.05); break; 
			case "SILVER": plusPoint = (int)Math.round(orders.getOtotalprice()*0.10); break;
			case "GOLD": plusPoint = (int)Math.round(orders.getOtotalprice()*0.15); break;
			case "VIP": plusPoint = (int)Math.round(orders.getOtotalprice()*0.20); break;
		}
		
		member.setMpoint(minusPoint);
		memberDAO.minusMpoint(member);
		
		member.setMpoint(plusPoint);
		memberDAO.plusMpoint(member);
		
		member.setMtotalprice(orders.getOtotalprice());
		memberDAO.updateMtotalprice(member);
		
		member = memberDAO.memberView(mid);
		int mtotalprice = member.getMtotalprice();
		
		String mgrade = null;
		if(mtotalprice>700000) {
			mgrade="VIP";
		}else if(mtotalprice>300000) {
			mgrade="GOLD";
		}else if(mtotalprice>100000) {
			mgrade="SILVER";
		}
		
		if(mgrade!=null) {//회원 총 결제 금액에 따른 등급 수정
			member.setMgrade(mgrade);
			memberDAO.updateMgrade(member);
		}
		
		String onum = ordersDAO.getOnum(mid);
		
		
		String encodedParam = URLEncoder.encode(mainmenu, "UTF-8");
		mav.setViewName("redirect:/honeycombo?hmainmenu="+encodedParam+"&onum="+onum+"&sid="+orders.getSid());
		
		return mav;
	}

	
	//수량 증가 처리
	public String updateCamount(CartDTO cart) {
		int updateResult = cartDAO.updateCamount(cart);
		String result = "";
		if(updateResult==1) {
			result = "success";
		}
		return result;
	}
	
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

	//회원 주문내역 조회
	public ModelAndView myOrdersList(String mid) {
		mav = memberProfile(mid);

		List<String> onumList = ordersDAO.myOnumList(mid);
		Map<String, List<OrdersDTO>> ordersMap = new HashMap<String, List<OrdersDTO>>();
		for(int i=0;i<onumList.size();i++) {
			List<OrdersDTO> ordersList = ordersDAO.myOrdersList(onumList.get(i));
			if(onumList.get(i).equals(ordersList.get(0).getOnum())) {
				ordersMap.put(onumList.get(i), ordersList);
			}

		}
		
		List<ReviewDTO> reviewList = reviewDAO.myReviewList(mid);
		Map<String, String> reviewMap = new HashMap<String, String>();
		for(int i=0;i<reviewList.size();i++) {
			reviewMap.put(reviewList.get(i).getOnum(),"리뷰있음");
		}
		
		mav.addObject("reviewMap", reviewMap);
		mav.addObject("onumList",onumList);
		mav.addObject("ordersMap",ordersMap);
		mav.setViewName("member/MyOrdersList");
		return mav;
	}

	//업체 주문 승낙
	public String ordersConfirm(String onum) {
		String confirmResult = ordersDAO.ordersConfirm(onum);
		
		
		return confirmResult;
	}
	
	//주문 취소
	public ModelAndView ordersCancel(String onum, String mid) {
		mav = new ModelAndView();
		
		ordersDAO.ordersCancel(onum);
		
		mav.setViewName("redirect:/myorderslist?mid="+mid);
		return mav;
	}
}
