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
		int cartCheck = cartDAO.cartCheck(cart);//다른 업체의 메뉴가 장바구니에 있는지 판별
		CartDTO checkedCart = cartDAO.menuCheck(cart);//같은 메뉴가 장바구니에 있는지 판별
		String cartAddResult = null;
		
		if(cartCheck>0) {
			cartAddResult="other"; //다른 업체의 메뉴는 장바구니에 담지 못함
		}else {
			if(checkedCart != null) {
				cart.setCnum(checkedCart.getCnum());
				cartAddResult = cartDAO.cartUpdate(cart);//같은 메뉴를 장바구니에 담을 시 수량이 추가됨
			}else {
				cartAddResult = cartDAO.cartAdd(cart); //메뉴 장바구니에 추가
			}
		}
		return cartAddResult;
	}

	//장바구니 리스트 조회
	public ModelAndView cartList(String mid) {
		mav = memberService.memberProfile(mid);
		
		List<CartDTO> cartList = cartDAO.cartList(mid);//장바구니 정보 가져오기
		HashMap<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
		for(int i=0;i<cartList.size();i++) {
			int menunum = cartList.get(i).getMenunum();
			MenuDTO menu = storeDAO.menuView(menunum); //menu번호에 맞게 MenuDTO 객체 생성
			menuMap.put(menunum, menu); //Cart번호에 따라 MenuDTO를 HashMap에 저장
		}
		
		mav.addObject("menuMap", menuMap);
		mav.addObject("cartList", cartList);
		mav.setViewName("member/CartList");
		return mav;
	}

	//장바구니 삭제
	public ModelAndView cartDelete(String mid, int cnum) {
		mav = new ModelAndView();
		
		int deleteResult = cartDAO.cartDelete(cnum);//장바구니 삭제
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
			CartDTO cart = cartDAO.cartGet(cnum);//orders에 저장된 장바구니 번호로 장바구니 정보 가져오기
			cartList.add(cart);
		}
		
		HashMap<Integer, MenuDTO> menuMap = new HashMap<Integer, MenuDTO>();
		for(int i=0;i<cartList.size();i++) {
			int menunum = cartList.get(i).getMenunum();
			MenuDTO menu = storeDAO.menuView(menunum);//메뉴 정보 가져오기
			menuMap.put(menunum, menu);
			if(menutime<menu.getMenutime()) {
				menutime = menu.getMenutime();//배달예상시간 설정
			}
		}
		
		List<AddressDTO> addressList = addressDAO.myAddressList(mid);//등록한 주소 정보가져오기
		List<CouponDTO> couponList = memberDAO.couponList(mid);//회원에게 있는 쿠폰 리스트 가져오기		
		
		
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
		memberDAO.couponDelete(couponnum);//입력된 쿠폰번호와 일치하는 쿠폰 삭제
		List<String> mainList = recommendDAO.mainList(); //꿀조합에 들어갈 메인메뉴 리스트
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
			if(ordersList.isEmpty()) { //orderList에 mid가 없다면
				memberDAO.firstCouponAdd(mid);//첫 구매 시 쿠폰제공
			}
			
			MenuDTO menu = storeDAO.menuView(menunum);
			if(maxTime < menu.getMenutime()) {
				maxTime = menu.getMenutime();//배달예상시간 설정
			}
			
			menu.setMenunum(menunum);
			menu.setMenuhit(camount);
			storeDAO.updateMenuHit(menu); //메뉴 총 주문 수 업데이트
			
			orders.setMid(mid);
			orders.setSid(sid);
			orders.setMenuname(menuname);
			orders.setStorename(storename);
			orders.setMenunum(menunum);
			orders.setMenuprice(menuprice);
			orders.setCamount(camount);
			orders.setOstatus("확인중");
			orders.setOtime(orders.getOtime()+maxTime); //카카오맵API로 계산한 배달시간 + 메뉴시간
			if(i==0) {
				StoreDTO store = new StoreDTO();
				store.setSid(sid);
				store.setSales(menuprice);
				storeDAO.updateStoreSales(store);//업체의 총 매출액 업데이트
				
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
				messageDAO.sendOrdersPay(message);//배달 성공 시 메시지 전송
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
						mainmenu = "기본";//꿀조합이 아무것도 없을 시 '기본'으로 설정
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
		memberDAO.minusMpoint(member);//사용한 포인트만큼 감소
		
		member.setMpoint(plusPoint);
		memberDAO.plusMpoint(member);//등급에 따라 포인트 지급
		
		member.setMtotalprice(orders.getOtotalprice());
		memberDAO.updateMtotalprice(member);//회원의 총 구매액 업데이트
		
		member = memberDAO.memberView(mid);
		int mtotalprice = member.getMtotalprice();
		
		String mgrade = null;
		if(mtotalprice>700000) {//총 구매액에 따라 등급 조정
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
