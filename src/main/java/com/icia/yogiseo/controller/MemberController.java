package com.icia.yogiseo.controller;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.http.HttpSession;
import org.codehaus.jackson.JsonNode;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.icia.yogiseo.api.KakaoJoinApi;
import com.icia.yogiseo.api.KakaoLoginApi;
import com.icia.yogiseo.api.NaverJoinApi;
import com.icia.yogiseo.api.NaverLoginApi;
import com.icia.yogiseo.dto.AddressDTO;
import com.icia.yogiseo.dto.FoodPreferenceDTO;
import com.icia.yogiseo.dto.MemberDTO;
import com.icia.yogiseo.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private HttpSession session;

	@Autowired
	private MemberService memberService;

	private ModelAndView mav;
	
	private NaverJoinApi naverJoinApi;
	
	private NaverLoginApi naverLoginApi;


	// 비디오 재생 페이지로 이동
	@RequestMapping(value="/")
	public String home() {
		return "video";
	}

	// 메인페이지로 이동
	@RequestMapping(value="/main")
	public String main() {
		return "Main";
	}

	// 관리자 회원목록 조회
	@RequestMapping(value="/memberlist")
	public ModelAndView memberList(@RequestParam("loginId") String loginId) {
		mav = memberService.memberList(loginId);
		return mav;
	}

	// 관리자 회원 상세조회
	@RequestMapping(value="/memberview")
	public ModelAndView memberView(@RequestParam("mid") String mid) {
		mav = memberService.adminMemberView(mid);
		return mav;
	}

	// 관리자 회원 삭제
	@RequestMapping(value="/adminmemberdelete")
	public ModelAndView memberDelete(@RequestParam("mid") String mid,@RequestParam("loginId") String loginId ) {
		mav = memberService.adminMemberDelete(mid, loginId);
		return mav;
	}

	// 회원 블랙리스트 조회
	@RequestMapping(value="/memberblacklist")
	public ModelAndView memberBlackList(@RequestParam("loginId") String loginId) {
		mav = memberService.memberBlackList(loginId);
		return mav;
	}

	// 회원 블랙리스트 해제
	@RequestMapping(value="/memberblacklistdelete")
	public ModelAndView memberBlackListDelete(@RequestParam("mid") String mid, @RequestParam("loginId") String loginId) {
		mav = memberService.memberBlackListDelete(mid, loginId);
		return mav;
	}

	// 회원 블랙리스트 추가
	@RequestMapping(value="/memberblacklistadd")
	public ModelAndView memberBlackListAdd(@RequestParam("mid") String mid, @RequestParam("loginId") String loginId) {
		mav = memberService.memberBlackListAdd(mid, loginId);
		return mav;
	}


	//회원가입화면 출력
	@RequestMapping(value="/memberjoinform", method = RequestMethod.GET)
	public String memberjoinform() {
		return "member/MemberJoinForm";
	}

	//회원가입 처리
	@RequestMapping(value="/memberjoin")
	public ModelAndView memberJoin(@ModelAttribute MemberDTO member, @ModelAttribute AddressDTO address) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		mav = memberService.memberJoin(member, address);

		return mav;
	}

	//음식선호도 입력처리
	@RequestMapping(value="/preferenceadd")
	public ModelAndView preferenceAdd(@ModelAttribute FoodPreferenceDTO foodpreference) {
		mav = new ModelAndView();
		mav = memberService.preferenceAdd(foodpreference);

		return mav;
	}


	//아이디 중복체크
	@RequestMapping(value="/idoverlap", method=RequestMethod.POST)
	public @ResponseBody String idOverlap(@RequestParam("id") String id) {
		String resultMsg = memberService.idOverlap(id);

		return resultMsg;
	}

	//이메일 인증 인증키 생성
	@RequestMapping(value="/createkey")
	public @ResponseBody String createKey(@RequestParam("email") String email) {
		//파라미터값 email을 String 변수에 담아줌
		String key = null;
		do {
			key = memberService.createKey(30,false);
			//30자의 랜덤인증키를 생성하는 creatKey메소드에서 랜덤인증키를 받아와 key라는 변수에 담아줌
		} while(memberService.insertKey(key)); //인증키를 DB에 삽입이 성공하면 true임으로 하단의 메소드 실행 
		String title = "요기서요기 회원가입 이메일 인증"; //보내는 메일 제목
		memberService.mailSending(email, title, key); //메일을 보내는 메소드

		return "OK";
	}

	//이메일 전송
	@RequestMapping(value="/sendemail")
	public @ResponseBody String sendemail(@RequestParam("email") String email) {
		String title = "요기서 요기 회원가입 이메일 인증";
		memberService.sendemail(email, title);

		return "OK";
	}

	//인증키 확인
	@RequestMapping(value="/checkkey", method = RequestMethod.POST)
	public @ResponseBody String checkKey(@RequestParam("key") String key) {
		String result = memberService.checkKey(key);
		//인증키 일치여부를 체크하는 checkKey메소드에 key값을 담아 전달하고 결과값을 String변수  result에 담아줌

		return result;
	}

	//회원 로그인화면 출력
	@RequestMapping(value="/memberloginform", method = RequestMethod.GET)
	public String memberloinform() {
		return "member/MemberLoginForm";
	}

	//회원 로그인 처리
	@RequestMapping(value="/memberlogin")
	public ModelAndView memberLogin(@ModelAttribute MemberDTO member) {
		mav = memberService.memberLogin(member);

		return mav;
	}

	//회원 로그아웃 처리
	@RequestMapping(value="/logout")
	public String Logout() {
		session.invalidate();

		return "Main";
	}

	//네이버 서버 불러오기
	@RequestMapping(value="/naverjoin")
	public ModelAndView naverJoin(HttpSession session) {
		mav = new ModelAndView();
		String naverUrl = naverJoinApi.getAuthorizationUrl(session);

		mav.addObject("naverUrl", naverUrl);
		mav.setViewName("member/NaverLogin");

		return mav;
	}	

	//네이버 서버 인증 통과 후 회원가입 처리
	@RequestMapping(value="/yoyonaverJoinOK")
	public ModelAndView naverJoinOK
	(@RequestParam("code") String code, @RequestParam("state") String state, HttpSession session) throws IOException, ParseException, org.json.simple.parser.ParseException {
		mav = new ModelAndView();
		OAuth2AccessToken oauthToken = naverJoinApi.getAccessToken(session, code, state);

		String profile = naverJoinApi.getUserProfile(oauthToken);

		JSONParser parser = new JSONParser();

		Object obj = parser.parse(profile);

		JSONObject naverUser = (JSONObject) obj;
		JSONObject userInfo = (JSONObject) naverUser.get("response");

		String naverId = (String) userInfo.get("id");

		mav.addObject("naverId", naverId);
		mav.setViewName("member/MemberJoinForm");

		return mav;	
	}

	//네이버 서버 로그인
	@RequestMapping(value="/naverlogin")
	public ModelAndView naverLogin(HttpSession session) {
		mav = new ModelAndView();
		System.out.println("세션: "+session);
		String naverUrl = naverLoginApi.getAuthorizationUrl(session);
		System.out.println("Url: "+naverUrl);
		mav.addObject("naverUrl", naverUrl);
		mav.setViewName("member/NaverLogin");

		return mav;
	}

	//네이버 서버 로그인 확인
	@RequestMapping(value="/yoyonaverLoginOK")
	public ModelAndView naverLoginOK
	(@RequestParam("code") String code, @RequestParam("state") String state, HttpSession session) throws IOException, ParseException, org.json.simple.parser.ParseException {
		mav = new ModelAndView();
		OAuth2AccessToken oauthToken = naverLoginApi.getAccessToken(session, code, state);
		String profile = naverLoginApi.getUserProfile(oauthToken);

		mav = memberService.naverLogin(profile); 

		return mav;
	}	
	//카카오 서버 불러오기
	@RequestMapping(value="/kakaojoin", method=RequestMethod.GET)
	public ModelAndView kakaoJoin(HttpSession session) {
		String kakaoUrl = KakaoJoinApi.getAuthorizationUrl(session);

		mav = new ModelAndView();
		mav.addObject("kakaoUrl", kakaoUrl);
		mav.setViewName("member/KakaoLogin");

		return mav;
	}

	//카카오 서버 인증 통과 후 회원가입 처리
	@RequestMapping(value="/yoyokakaoJoinOK")
	public ModelAndView kakaoJoinOK(@RequestParam("code") String code, HttpSession session) {
		mav = new ModelAndView();
		JsonNode token = KakaoJoinApi.getAccessToken(code);
		JsonNode profile = KakaoJoinApi.getKakaoUserInfo(token.path("access_token"));

		mav = memberService.kakaoJoin(profile);

		return mav;
	}

	//카카오 서버 로그인
	@RequestMapping(value="/kakaologin", method=RequestMethod.GET)
	public ModelAndView kakaoLogin(HttpSession session) {
		String kakaoUrl = KakaoLoginApi.getAuthorizationUrl(session);

		mav = new ModelAndView();
		mav.addObject("kakaoUrl", kakaoUrl);
		mav.setViewName("member/KakaoLogin");

		return mav;
	}	

	//카카오 서버 로그인 확인
	@RequestMapping(value="/yoyokakaoLoginOK")
	public ModelAndView kakaoLoginOK(@RequestParam("code") String code, HttpSession session) {
		mav = new ModelAndView();

		JsonNode token = KakaoLoginApi.getAccessToken(code);
		JsonNode profile = KakaoLoginApi.getKakaoUserInfo(token.path("access_token"));

		mav = memberService.kakaoLogin(profile);

		return mav;
	}

	//회원 마이페이지 출력
	@RequestMapping(value="/memberpage")
	public ModelAndView memeberPage(@RequestParam("mid") String mid) {
		mav = new ModelAndView();
		mav = memberService.memberPage(mid);

		return mav;
	}

	// 관리자 마이페이지 출력
	@RequestMapping(value="/adminpage")
	public ModelAndView adminPage(@RequestParam("loginId") String loginId) {
		mav = new ModelAndView();
		mav = memberService.adminPage(loginId);

		return mav;
	}

	//회원정보 수정 데이터 요청
	@RequestMapping(value="membermodify")
	public ModelAndView memberModify(@RequestParam("mid") String mid) {
		mav = new ModelAndView();
		mav = memberService.memberView(mid);

		return mav;
	}

	//리뷰 작성화면 출력
	@RequestMapping(value = "/reviewwriteform", method = RequestMethod.GET)
	public ModelAndView reviewWriteForm(@RequestParam("onum") String onum, @RequestParam("menunum") int menunum) {
		mav = memberService.reviewWriteForm(onum,menunum);
		return mav;
	}

	//회원정보 수정
	@RequestMapping(value="/membermodifyprocess")
	public ModelAndView memberModifyProcess(@ModelAttribute MemberDTO member) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		mav = memberService.memberModifyProcess(member);
		return mav;
	}

	//회원탈퇴화면 이동
	@RequestMapping(value="memberdeleteform")
	public ModelAndView memberDeleteForm(@RequestParam("mid") String mid) {
		mav = new ModelAndView();
		mav = memberService.memberDeleteForm(mid);
		return mav;
	}

	//탈퇴시 회원 비밀번호 확인
	@RequestMapping(value="passwordcheck")
	public @ResponseBody String passwordCheck(@ModelAttribute MemberDTO member) {
		String resultMsg = memberService.passwordCheck(member);
		return resultMsg; 
	}

	//회원탈퇴 처리
	@RequestMapping(value="memberdelete")
	public ModelAndView memberDelete(@RequestParam("mid") String mid) {
		mav = new ModelAndView();
		mav = memberService.memberDelete(mid);
		session.invalidate();

		return mav;
	}

	//쿠폰목록 조회
	@RequestMapping(value="couponlist")
	public ModelAndView couponList(@RequestParam("mid") String mid){
		mav = new ModelAndView();
		mav = memberService.couponList(mid);

		return mav;
	}
	
	//구글 아이디의 유무 확인
		@RequestMapping(value="/checkgoogleid")
		public @ResponseBody String checkGoogleId(@ModelAttribute MemberDTO member) {
			String resultMsg = memberService.checkGoogleId(member);
			
			return resultMsg;
			
		}
		
		//구글 로그인 처리
		@RequestMapping(value="/googleloginok")
		public ModelAndView googleLoginOk(@ModelAttribute MemberDTO member) {
			mav = memberService.googleLoginOk(member);
			
			return mav;
		}
		
		//구글 회원가입화면 출력
		@RequestMapping(value="/googlejoinform")
		public ModelAndView googleJoinForm(@ModelAttribute MemberDTO member) {
			mav = memberService.googleJoinForm(member);
			
			return mav;
		}



}
