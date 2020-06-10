package com.icia.yogiseo.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.yogiseo.dto.MenuDTO;
import com.icia.yogiseo.dto.ReviewDTO;
import com.icia.yogiseo.dto.SearchDTO;
import com.icia.yogiseo.dto.SenderDTO;
import com.icia.yogiseo.dto.StoreBlackListDTO;
import com.icia.yogiseo.dto.StoreDTO;

@Repository
public class StoreDAO {
	@Autowired
	SqlSessionTemplate sql;
	
	//음식점 검색
	public List<StoreDTO> searchBy(SearchDTO search) {
		return sql.selectList("Store.searchBy", search);
	}
	
	//음식점 상세
	public StoreDTO storeView(String sid) {
		return sql.selectOne("Store.storeView", sid);
	}

	public int storeJoin(StoreDTO store) {
		return sql.insert("Store.storeJoin", store);
	}

	public String idOverlap(String id) {
		return sql.selectOne("Store.idOverlap", id);
	}

	public String storeLogin(StoreDTO store) {
		return sql.selectOne("Store.storeLogin", store);
	}

	//업체 음식점 메뉴 조회
	public List<MenuDTO> menuList(String sid) {
		return sql.selectList("Store.menuList", sid);
	}

	public int menuAdd(MenuDTO menu) {
		return sql.insert("Store.menuAdd", menu);
	}

	public int menuDelete(int menunum) {
		return sql.delete("Store.menuDelete",menunum);
	}

	//메뉴 상세정보
	public MenuDTO menuView(int menunum) {
		return sql.selectOne("Store.menuView", menunum);
	}

	public int menuModify(MenuDTO menu) {
		return sql.update("Store.menuModify", menu);
	}

	//업체 아이디로 REVIEW테이블 조회
	public List<ReviewDTO> reviewList(String sid) {
		return sql.selectList("Store.reviewList", sid);
	}

	//업체 음식점 신청
	public int storeConfirm(String sid) {
		return sql.update("Store.storeConfirm",sid);
	}

	//업체정보 수정 처리
	public int storeModify(StoreDTO store) {
		return sql.update("Store.storeModify", store);
	}

	public int storeDelete(String sid) {
		return sql.delete("Store.storeDelete", sid);
	}

	public int storeCheck(String sid, String passwordcheck) {
		HashMap<String, String> checkMap = new HashMap<String, String>();
		System.out.println("sid:"+sid);
		System.out.println("passwordcheck:"+passwordcheck);
		checkMap.put("sid",sid);
		checkMap.put("passwordcheck",passwordcheck);

		return sql.selectOne("Store.storeCheck", checkMap);
	}

	// 관리자 업체 목록 조회
	public List<StoreDTO> adminStoreList() {
		return sql.selectList("Store.adminStoreList");
	}

	//관리자 업체 상세 조회
	public StoreDTO adminStoreView(String sid) {
		return sql.selectOne("Store.adminStoreView", sid);
	}

	// 관리자 업체 블랙리스트 조회
	public List<StoreBlackListDTO> storeBlackList() {
		return sql.selectList("Store.storeBlackList");
	}

	// 관리자 업체 블랙리스트 정지해제 업데이트
	public int storeBlackListModify(String sid) {
		return sql.delete("Store.storeBlackListModify", sid);
	}

	// 관리자 업체 블랙리스트 정지해제 업데이트 후 블랙리스트 테이블에서 삭제
	public int storeBlackListDelete(String sid) {
		return sql.delete("Store.storeBlackListDelete", sid);
	}

	// 관리자 업체 블랙리스트 정지설정 업데이트
	public int storeBlackListUpdate(String sid) {
		return sql.update("Store.storeBlackListUpdate", sid);
	}

	// 관리자 업체 블랙리스트 정지설정 업데이트 후 블랙리스트 테이블에 추가
	public int storeBlackListAdd(String sid) {
		return sql.insert("Store.storeBlackListAdd", sid);
	}

	// 관리자 음식점 신청 업체 리스트 조회
	public List<StoreDTO> storeAddList() {
		return sql.selectList("Store.storeAddList");
	}

	// 관리자 음식점 신청 업체 승인 처리
	public int storeAddConfirm(String sid) {
		return sql.update("Store.storeAddConfirm", sid);
	}

	// 관리자 음식점 신청 업체 거절 처리
	public int storeAddReject(String sid) {
		return sql.update("Store.storeAddReject", sid);
	}
	public List<String> sidList(String searchWord) {
		return sql.selectList("Store.sidList", searchWord);
	}

	public StoreDTO searchStoreList(String sid) {
		return sql.selectOne("Store.searchStoreList", sid);
	}

	//업체 총 매출액 업데이트
	public void updateStoreSales(StoreDTO store) {
		sql.update("Store.updateStoreSales", store);
	}	
	
	public SenderDTO storeNameList(String senderid) {
		return sql.selectOne("Store.storeNameList", senderid);
	}

	//메뉴 주문 수 업데이트
	public void updateMenuHit(MenuDTO menu) {
		sql.update("Store.updateMenuHit", menu);
	}

	public int getMatCategory(StoreDTO store) {
		return sql.update("Store.getMatCategory", store);
	}	

	public int storeCount1(String sid) {
		return sql.selectOne("Store.storeCount1", sid);
	}

}
