package com.icia.yogiseo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.yogiseo.dto.HoneyComboDTO;
import com.icia.yogiseo.dto.OrdersDTO;
import com.icia.yogiseo.dto.PagingDTO;
import com.icia.yogiseo.dto.RateDTO;
import com.icia.yogiseo.dto.RecommendResultDTO;
import com.icia.yogiseo.dto.ReviewDTO;
import com.icia.yogiseo.dto.SearchDTO;
import com.icia.yogiseo.dto.StoreDTO;
import com.icia.yogiseo.dto.TasteDTO;
import com.icia.yogiseo.dto.VoucherDTO;

@Repository
public class RecommendDAO {
	
	
	@Autowired
	private SqlSessionTemplate sql;
	

	public List<RecommendResultDTO> searchTaste1(TasteDTO taste) {
		return sql.selectList("Recommend.searchTaste1", taste);
	}
	
	public List<RecommendResultDTO> searchTaste2(TasteDTO taste) {
		return sql.selectList("Recommend.searchTaste2", taste);
	}
	
	public List<RecommendResultDTO> searchTaste3(TasteDTO taste) {
		return sql.selectList("Recommend.searchTaste3", taste);
	}

	public List<RecommendResultDTO> searchTaste4(TasteDTO taste) {
		return sql.selectList("Recommend.searchTaste4", taste);
	}

	public List<String> honeyCombo(String hmainmenu) {
		return sql.selectList("Recommend.honeyCombo", hmainmenu);
	}

	public List<OrdersDTO> orderList() {
		return sql.selectList("Recommend.orderList");
	}

	public List<String> mainList() {
		return sql.selectList("Recommend.mainList");
	}

	public List<StoreDTO> recommendStoreList(StoreDTO store) {
		return sql.selectList("Recommend.recommendStoreList", store);
	}

	public List<String> storeNameList() {
		return sql.selectList("Recommend.storeNameList");
	}

	public StoreDTO voucherStoreList(String sid) {
		return sql.selectOne("Recommend.voucherStoreList", sid);
	}

	public double getRrate(String sid) {
		return sql.selectOne("Recommend.getRrate", sid);
	}

	public List<RateDTO> rateList() {
		return sql.selectList("Recommend.rateList");
	}

	public StoreDTO bestList(String sid) {
		return sql.selectOne("Recommend.bestList", sid);
	}

	public List<StoreDTO> sList() {
		return sql.selectList("Recommend.sList");
	}

	public ReviewDTO getReview(String sid) {
		return sql.selectOne("Recommend.getReview", sid);
	}

	public String getMimg(String mid) {
		return sql.selectOne("Recommend.getMimg", mid);
	}

	public int ordersCount(HoneyComboDTO honey) {
		return sql.selectOne("Recommend.ordersCount", honey);
	}

	


	
}
