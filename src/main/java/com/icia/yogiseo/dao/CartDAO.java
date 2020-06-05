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

	public String cartAdd(CartDTO cart) {
		String cartAddResult = null;
		if(sql.insert("Cart.cartAdd", cart) == 1) {
			cartAddResult = "success";
		}
	
		return cartAddResult;
	}

	public List<CartDTO> cartList(String mid) {
		return sql.selectList("Cart.cartList", mid);
	}

	public int cartCheck(CartDTO cart) {
		return sql.selectOne("Cart.cartCheck", cart);
	}

	public int cartDelete(int cnum) {
		return sql.delete("Cart.cartDelete", cnum);
	}

	public CartDTO menuCheck(CartDTO cart) {
		return sql.selectOne("Cart.menuCheck",cart);
	}

	public String cartUpdate(CartDTO cart) {
		String cartAddResult = null;
		if(sql.update("Cart.cartUpdate", cart) == 1) {
			cartAddResult = "success";
		}
	
		return cartAddResult;
	}
	
	public CartDTO cartGet(int cnum) {
		return sql.selectOne("Cart.cartGet",cnum);
	}

	public int updateCamount(CartDTO cart) {
		return sql.update("Cart.updateCamount",cart);
	}

	
	
}
