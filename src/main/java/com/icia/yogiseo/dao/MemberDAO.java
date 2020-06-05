package com.icia.yogiseo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.yogiseo.dto.AddressDTO;
import com.icia.yogiseo.dto.CouponDTO;
import com.icia.yogiseo.dto.FoodPreferenceDTO;
import com.icia.yogiseo.dto.MemberBlackListDTO;
import com.icia.yogiseo.dto.MemberDTO;
import com.icia.yogiseo.dto.OrdersDTO;
import com.icia.yogiseo.dto.SenderDTO;

@Repository
public class MemberDAO {
	@Autowired
	SqlSessionTemplate sql;

	// 관리자 회원 목록 조회
	public List<MemberDTO> memberList() {
		return sql.selectList("Member.memberList");
	}

	// 관리자 회원 대표주소 조회
	public AddressDTO memberAddress(String mid) {
		return sql.selectOne("Member.memberAddress", mid);
	}

	// 관리자 회원 상세조회
	public MemberDTO memberView(String mid) {
		return sql.selectOne("Member.memberView", mid);
	}

	// 마이페이지 내정보
	public MemberDTO myProfile(String loginId) {
		return sql.selectOne("Member.memberView", loginId);
	}

	// 관리자 회원 삭제
	public int memberDelete(String mid) {
		return sql.delete("Member.memberDelete", mid);
	}

	// 관리자 회원 블랙리스트 조회
	public List<MemberBlackListDTO> memberBlackList() {
		return sql.selectList("Member.memberBlackList");
	}

	// 관리자 회원 블랙리스트 정지 해제 여부 업데이트
	public int memberBlackListModify(String mid) {
		return sql.update("Member.memberBlackListModify", mid);
	}

	// 관리자 회원 블랙리스트 정지 해제 여부 업데이트 후 블랙리스트 테이블에서 삭제
	public int memberBlackListDelete(String mid) {
		return sql.delete("Member.memberBlackListDelete", mid);
	}

	// 관리자 회원 블랙리스트 정지 추가 여부 업데이트
	public int memberBlackListUpdate(String mid) {
		return sql.update("Member.memberBlackListUpdate", mid);
	}

	// 관리자 회원 블랙리스트 정지 추가 여부 업데이트 후 블랙리스트 테이블에 추가
	public int memberBlackListAdd(String mid) {
		return sql.delete("Member.memberBlackListAdd", mid);
	}



	public MemberDTO memberPage() {
		return sql.selectOne("Member.memberPage");
	}

	public int memberJoin(MemberDTO member) {
		if(member.getNaverid() != null) {
			return sql.insert("Member.naverMemberJoin", member);
		}else if(member.getKakaoid() != null){
			return sql.insert("Member.kakaoMemberJoin", member);
		}else{
			return sql.insert("Member.memberJoin", member);
		}
	}

	public String idOverlap(String id) {
		return sql.selectOne("Member.idOverlap", id);
	}

	public int insertKey(String key) {
		return sql.insert("Member.insertKey", key);
	}

	public String checkKey(String key) {
		return sql.selectOne("Member.checkKey", key);
	}

	public String memberLogin(MemberDTO member) {
		return sql.selectOne("Member.memberLogin", member);
	}

	public MemberDTO naverLogin(String naverId) {
		return sql.selectOne("Member.naverLogin", naverId);
	}

	public MemberDTO kakaoLogin(String kakaoId) {
		return sql.selectOne("Member.kakaoLogin", kakaoId);
	}

	public int addressAdd(AddressDTO address) {
		return sql.insert("Member.addressAdd", address);
	}

	public int preferenceAdd(FoodPreferenceDTO foodpreference) {
		return sql.insert("Member.preferenceAdd", foodpreference);
	}


	public int memberModifyProcess(MemberDTO member) {
		return sql.update("Member.memberModifyProcess", member);
	}

	public String passwordCheck(MemberDTO member) {
		return sql.selectOne("Member.passwordCheck", member);
	}


	public int couponAdd(String mid) {
		return sql.insert("Member.couponAdd", mid);
	}

	public List<CouponDTO> couponList(String mid) {
		return sql.selectList("Member.couponList", mid);
	}

	public int couponCount(String mid) {
		return sql.selectOne("Member.couponCount", mid);
	}

	public void firstCouponAdd(String mid) {
		sql.insert("Member.firstCouponAdd", mid);
		System.out.println(1234);
	}

	public void couponDelete(int couponnum) {
		sql.delete("Member.couponDelete", couponnum);
	}

	public void minusMpoint(MemberDTO member) {
		sql.update("Member.minusMpoint",member);
	}

	public void plusMpoint(MemberDTO member) {
		sql.update("Member.plusMpoint",member);
	}

	public void updateMtotalprice(MemberDTO member) {
		sql.update("Member.updateMtotalprice", member);
	}

	public void updateMgrade(MemberDTO member) {
		sql.update("Member.updateMgrade", member);
	}
	//메시지 보낸 member리스트
	public SenderDTO memberNameList(String senderid) {
		return sql.selectOne("Member.memberNameList", senderid);
	}
	//구글 로그인
	public String checkGoogleId(MemberDTO member) {
		return sql.selectOne("Member.checkGoogleId", member);
	}

}
