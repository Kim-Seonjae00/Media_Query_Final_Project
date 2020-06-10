package com.icia.yogiseo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.yogiseo.dto.CartDTO;

@Repository
public class CartDAO {
	@Autowired
	SqlSessionTemplate sql;
	
	//메뉴 추가
	public String cartAdd(CartDTO cart) {
		String cartAddResult = null;
		if(sql.insert("Cart.cartAdd", cart) == 1) {
			cartAddResult = "success";
		}
	
		return cartAddResult;
	}

	//장바구니 정보 가져오기
	public List<CartDTO> cartList(String mid) {
		return sql.selectList("Cart.cartList", mid);
	}
	
	//다른 업체가 있는지 판별
	public int cartCheck(CartDTO cart) {
		return sql.selectOne("Cart.cartCheck", cart);
	}

	//장바구니 삭제
	public int cartDelete(int cnum) {
		return sql.delete("Cart.cartDelete", cnum);
	}

	//중복된 메뉴 판별
	public CartDTO menuCheck(CartDTO cart) {
		return sql.selectOne("Cart.menuCheck",cart);
	}
	
	//중복된 메뉴 시 갯수 증가
	public String cartUpdate(CartDTO cart) {
		String cartAddResult = null;
		if(sql.update("Cart.cartUpdate", cart) == 1) {
			cartAddResult = "success";
		}
	
		return cartAddResult;
	}
	
	//장바구니 가져오기
	public CartDTO cartGet(int cnum) {
		return sql.selectOne("Cart.cartGet",cnum);
	}

	public int updateCamount(CartDTO cart) {
		return sql.update("Cart.updateCamount",cart);
	}

	
	
}
