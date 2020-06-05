package com.icia.yogiseo.service;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dao.MemberDAO;
import com.icia.yogiseo.dao.OrdersDAO;
import com.icia.yogiseo.dao.ReviewDAO;
import com.icia.yogiseo.dao.StoreDAO;
import com.icia.yogiseo.dto.AddressDTO;
import com.icia.yogiseo.dto.CouponDTO;
import com.icia.yogiseo.dto.FoodPreferenceDTO;
import com.icia.yogiseo.dto.MemberBlackListDTO;
import com.icia.yogiseo.dto.MemberDTO;
import com.icia.yogiseo.dto.MenuDTO;
import com.icia.yogiseo.dto.OrdersDTO;
import com.icia.yogiseo.dto.ReviewDTO;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private ReviewDAO reviewDAO;
	@Autowired
	private StoreDAO storeDAO;
	
	private ModelAndView mav;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private OrdersDAO ordersDAO;

	// 관리자 회원 목록 조회
	public ModelAndView memberList(String loginId) {
		mav = new ModelAndView();
		
		List<MemberDTO> memberList = new ArrayList<MemberDTO>();
		memberList = memberDAO.memberList();
		
		MemberDTO profile = memberDAO.myProfile(loginId);
		
		mav.addObject("profile", profile);
		mav.addObject("memberList", memberList);
		mav.setViewName("admin/MemberList");
		
		return mav;
	}

	// 관리자 회원 상세보기
	public ModelAndView adminMemberView(String mid) {
		mav = new ModelAndView();
		MemberDTO memberView = memberDAO.memberView(mid);
		
		List<ReviewDTO> memberReviewList = new ArrayList<ReviewDTO>();
		memberReviewList = reviewDAO.memberReviewList(mid);
		
		AddressDTO address = memberDAO.memberAddress(mid);
		
		mav.addObject("address", address);
		mav.addObject("memberReviewList", memberReviewList);
		mav.addObject("member", memberView);
		mav.setViewName("admin/MemberView");
		
		return mav;
	}

	// 관리자 회원 삭제
	public ModelAndView adminMemberDelete(String mid, String loginId) {
		mav = new ModelAndView();
		int deleteResult = memberDAO.memberDelete(mid);
		
		if(deleteResult == 1) {
			mav.setViewName("redirect:/memberlist?loginId="+loginId);			
		} else {
			mav.setViewName("Fail");
		}
		
		return mav;
	}

	// 관리자 회원 블랙리스트 조회
	public ModelAndView memberBlackList(String loginId) {
		mav = new ModelAndView();
		List<MemberBlackListDTO> memberBlackList = memberDAO.memberBlackList();
		MemberDTO profile = memberDAO.myProfile(loginId);
		
		mav.addObject("profile", profile);
		mav.addObject("memberBlackList", memberBlackList);
		mav.setViewName("admin/MemberBlackList");
		return mav;
	}

	// 관리자 회원 블랙리스트 해제
	public ModelAndView memberBlackListDelete(String mid, String loginId) {
		mav = new ModelAndView();
		
		int deleteResult = 0;
		int modifyResult = memberDAO.memberBlackListModify(mid);
		
		if(modifyResult == 1) {
			deleteResult = memberDAO.memberBlackListDelete(mid);
				if(deleteResult == 1) {
					mav.setViewName("redirect:/memberblacklist?loginId="+loginId);
				} else {
					mav.setViewName("Fail");
				}
		} else {
			mav.setViewName("Fail");
		}
		return mav;
	}

	// 회원 블랙리스트 추가
	public ModelAndView memberBlackListAdd(String mid, String loginId) {
		mav = new ModelAndView();
		
		int insertResult = 0;
		int updateResult = memberDAO.memberBlackListUpdate(mid);
		
		if(updateResult == 1) {
			insertResult = memberDAO.memberBlackListAdd(mid);
			if(insertResult == 1) {
				mav.setViewName("redirect:/memberblacklist?loginId="+loginId);
			} else {
				mav.setViewName("Fail");
			}
		} else {
			mav.setViewName("Fail");
		}
		
		return mav;
	}
	
	// 회원가입 처리
	public ModelAndView memberJoin(MemberDTO member, AddressDTO address) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		
		MultipartFile mimgFile = member.getMimgfile();
		String mimg = mimgFile.getOriginalFilename(); 
		
		String savePath = "C:\\Users\\4\\Desktop\\Development\\Source\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\Profile\\"+mimg;
		
		if(!mimgFile.isEmpty()) {
				mimgFile.transferTo(new File(savePath));
		}
		member.setMimg(mimg);
		
		int joinResult = memberDAO.memberJoin(member);
		int addResult = memberDAO.addressAdd(address);
		memberDAO.couponAdd(member.getMid());
		if(joinResult > 0 && addResult > 0){
			mav.addObject("mid", member.getMid());
			mav.setViewName("member/FoodPreference");
		}else {
			mav.setViewName("Fail");
		}
		return mav;
	}

	// 아이디 중복 확인
	public String idOverlap(String id) {
		String checkResult = memberDAO.idOverlap(id);
		String resultMsg = null;
		
		if(checkResult==null){ 
			resultMsg = "OK";
		}else {
			resultMsg = "NO";
		}
		
		return resultMsg;
	}
	
	//랜덤인증키 생성 
	public String createKey(int size, boolean lowerCheck) {
		//int 타입의 size는 컨트롤러에서 전달한 30, boolean타입의 lowerCheck false값이 전달되서 옴
		Random ran = new Random();
		StringBuffer sb = new StringBuffer(); //문자열 생성타입의 StringBuffer sb변수 선언
		int num = 0;
		do {
			num = ran.nextInt(75) + 48;
			if((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num); //num값의 숫자를 문자형으로 강제변환 후 문자열을 생성함
			} else {
				continue;
			}
 		} while (sb.length() < size);
		if(lowerCheck) {
			return sb.toString().toLowerCase(); //크기가 더 작은 경우의 문자열을 반환
		}
		return sb.toString(); //문자열 반환
	}

	//인증키 DB삽입
	public boolean insertKey(String key) {
		int result = memberDAO.insertKey(key); //key값을 가지고 overKey메소드로 이동하여 결과값을 int타입의 변수 result에 담음
		if(result == 0) {
			return true;
		}
		return false;
	}

	//메일보내기
	public void mailSending(String email, String title, String key) {
		String setfrom = "a33286350@gmail.com";
		try {
			MimeMessage message = mailSender.createMimeMessage();
			System.out.println("setfrom : "+setfrom);
			System.out.println("email : "+email);
			System.out.println("title : "+title);
			System.out.println("key : "+key);
			MimeMessageHelper messageHelper;
			messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(setfrom);
			messageHelper.setTo(email);
			messageHelper.setSubject(title);
			messageHelper.setText("안녕하세요 회원님."+"\n저희 요기서 요기를 찾아주셔서 감사합니다.\n"
					+ "\n회원가입에 필요한 인증번호는\n\n"+key+" 입니다.\n"
					+ "\n인증번호를 회원가입페이지의 인증번호란에 입력해주시면 인증절차가 완료됩니다.\n"
					+ "\n앞으로도 많은 사랑 부탁드립니다."
					+ "\n감사합니다.");
			mailSender.send(message);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//이메일 전송
	public void sendemail(String email, String title) {
		String setfrom = "9305good@gmail.com";
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper;
			messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom(setfrom);
			messageHelper.setTo(email);
			messageHelper.setSubject(title);
			messageHelper.setText("이메일 전송확인");
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
	}

	//인증키 일치여부 확인
	public String checkKey(String key) {
		String keyResult = memberDAO.checkKey(key);
		//keyResult라는 문자열 변수를 생성하고 memberDAO의 checkKey의 결과값을 담아줌
		if(keyResult != null) {
			return "1";
		}
		return "0";
	}

	// 회원 로그인 처리
	public ModelAndView memberLogin(MemberDTO member) {
		mav = new ModelAndView();
		String loginId = memberDAO.memberLogin(member);
		
		if(loginId != null) {
			session.setAttribute("loginId", loginId);
			mav.setViewName("Main");
		}else {
			mav.setViewName("LoginFail");
		}
		
		return mav;
	}

	// 네이버로그인 처리
	public ModelAndView naverLogin(String profile) throws ParseException, org.json.simple.parser.ParseException {
		mav = new ModelAndView();
		JSONParser parser = new JSONParser();
		
		Object obj = parser.parse(profile);
	
		JSONObject naverUser = (JSONObject) obj;
		JSONObject userInfo = (JSONObject) naverUser.get("response");
		
		String naverId = (String) userInfo.get("id");
		MemberDTO member = memberDAO.naverLogin(naverId); 
		
		session.setAttribute("loginId", member.getMid());
		mav.addObject("naverId", naverId);
		mav.setViewName("Main");
		
		return mav;
	}
	

	//카카오 서버 인증 통과 후 회원가입 처리
	public ModelAndView kakaoJoin(JsonNode profile) {
		mav = new ModelAndView();
		
		String kakaoId = profile.get("id").asText();
		
		mav.addObject("kakaoId", kakaoId);
		mav.setViewName("member/MemberJoinForm");
		
		return mav;
	}
	
	//카카오 서버 로그인 확인
	public ModelAndView kakaoLogin(JsonNode profile) {
		mav = new ModelAndView();
		
		String kakaoId = profile.get("id").asText();
		
		JsonNode kakaoAccount = profile.get("kakao_account");
		JsonNode kakaoProfile = kakaoAccount.get("profile");
		
		
		MemberDTO member = memberDAO.kakaoLogin(kakaoId);
		
		session.setAttribute("loginId", member.getMid());
		mav.addObject("kakaoId", kakaoId);
		mav.addObject("loginMember", member);
		mav.addObject("kakaoProfile", kakaoProfile);
		mav.setViewName("Main");
		
		return mav;
	}
	

	//선호도 조사
	public ModelAndView preferenceAdd(FoodPreferenceDTO foodpreference) {
		mav = new ModelAndView();
		
		int addResult = memberDAO.preferenceAdd(foodpreference);
		if(addResult > 0)
			mav.setViewName("member/MemberJoinSuccess");
		else
			mav.setViewName("Fail");
		
		return mav;
	}


	// 회원 마이페이지로 이동
	public ModelAndView memberPage(String mid) {
		mav = new ModelAndView();
		MemberDTO member = memberDAO.memberView(mid);
		mav.addObject("member", member);
		mav.setViewName("member/MemberPage");
		
		return mav;
	}
	
	// 관리자 마이페이지로 이동
	public ModelAndView adminPage(String loginId) {
		mav = new ModelAndView();
		
		MemberDTO profile = memberDAO.myProfile(loginId);
		mav.addObject("profile", profile);
		mav.setViewName("admin/AdminPage");
		return mav;
	}
	

	// 회원 상세보기
	public ModelAndView memberView(String mid) {
		mav = new ModelAndView();
		MemberDTO member = memberDAO.memberView(mid);
		mav.addObject("member", member);
		mav.setViewName("member/MemberModify");
		
		return mav;
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
	
	//회원정보 수정 화면 출력
	public ModelAndView memberModify(String mid) {
		mav = memberProfile(mid);
		mav.setViewName("member/MemberModify");
		return mav;
	}

	//회원정보 수정 처리
	public ModelAndView memberModifyProcess(MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();

		MultipartFile mimgFile = member.getMimgfile();
		String mimg = mimgFile.getOriginalFilename(); 

		String savePath = "C:\\Users\\4\\Desktop\\Development\\Source\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\Profile\\"+mimg;

		if(!mimgFile.isEmpty()) {
			mimgFile.transferTo(new File(savePath));
		}else {
			mimg = member.getMimg();
		}
		member.setMimg(mimg);

		int modifyResult = memberDAO.memberModifyProcess(member);
		if(modifyResult > 0)
			mav.setViewName("member/ModifySuccess");
		else
			mav.setViewName("Fail");

		return mav;
	}

	//회원 탈퇴 화면 이동
	public ModelAndView memberDeleteForm(String mid) {
		mav = memberProfile(mid);
		mav.setViewName("member/MemberDelete");

		return mav;
	}	

	//탈퇴시 회원 비밀번호 확인
	public String passwordCheck(MemberDTO member) {
		String checkResult = memberDAO.passwordCheck(member);
		String resultMsg = null;

		if(checkResult != null){ 
			resultMsg = "OK";
		}else {
			resultMsg = "NO";
		}

		return resultMsg;
	}

	//회원 탈퇴 처리
	public ModelAndView memberDelete(String mid) {
		mav = new ModelAndView();

		int deleteResult = memberDAO.memberDelete(mid);

		if(deleteResult == 1) {
			mav.setViewName("Main");
		}else {
			mav.setViewName("Fail");
		}

		return mav;
	}

	//회원 삭제 처리
	public ModelAndView adminMemberDelete(String mid) {
		mav = new ModelAndView();
		int deleteResult = memberDAO.memberDelete(mid);

		if(deleteResult == 1) {
			mav.setViewName("redirect:/memberlist");			
		} else {
			mav.setViewName("Fail");
		}

		return mav;
	}

	//쿠폰 목록 조회
	public ModelAndView couponList(String mid) {
		mav = memberProfile(mid);

		List<CouponDTO> coupon = memberDAO.couponList(mid);

		mav.addObject("couponList", coupon);
		mav.setViewName("member/CouponList");

		return mav;
	}

	// 리뷰 작성화면 이동
	public ModelAndView reviewWriteForm(String onum, int menunum) {
		mav = new ModelAndView();
		
		List<OrdersDTO> ordersList = ordersDAO.myOrdersList(onum);
		
		OrdersDTO orders = ordersList.get(0);
		
		String menuname = orders.getMenuname()+"외 "+ordersList.size()+"건";
		orders.setMenuname(menuname);
		
		MenuDTO menu = storeDAO.menuView(menunum);
		
		mav.addObject("menu", menu);
		mav.addObject("orders", orders);
		mav.setViewName("member/ReviewWrite");
		return mav;
	}
	
	
	//구글 아이디의 유무 확인
		public String checkGoogleId(MemberDTO member) {
			String result = memberDAO.checkGoogleId(member);
			String resultMsg = null;
			
			if(result != null) {
				resultMsg = "OK";
			}else {
				resultMsg = "NO";
			}
			
			return resultMsg;
		}

		//구글 로그인 처리
		public ModelAndView googleLoginOk(MemberDTO member) {
			mav = new ModelAndView();
			
			String loginId = memberDAO.checkGoogleId(member);
			
			if(loginId != null) {
				session.setAttribute("loginId", loginId);
				mav.setViewName("Main");
			}else {
				mav.setViewName("LoginFail");
			}
			
			return mav;
		}

		//구글 회원가입 화면 출력
		public ModelAndView googleJoinForm(MemberDTO member) {
			mav = new ModelAndView();
			
			mav.addObject("member", member);
			mav.setViewName("member/GoogleJoinForm");
			
			return mav;
		}	
	
	
	
	
}
