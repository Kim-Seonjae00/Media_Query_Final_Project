package com.icia.yogiseo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.yogiseo.dto.VoucherBuyDTO;
import com.icia.yogiseo.dto.VoucherDTO;

@Repository
public class VoucherDAO {

	
	@Autowired
	private SqlSessionTemplate sql;
	
	public int voucherAdd(VoucherDTO voucher) {
		return sql.insert("Voucher.voucherAdd", voucher);
	}

	public List<VoucherDTO> voucherList() {
		return sql.selectList("Voucher.voucherList");
	}
	
	public List<VoucherDTO> adminVoucherList() {
		return sql.selectList("Voucher.adminVoucherList");
	}

	public int voucherDelete(String vnum) {
		return sql.delete("Voucher.voucherDelete", vnum);
	}

	public VoucherDTO voucherView(String vname) {
		return sql.selectOne("Voucher.voucherView", vname);
	}

	public String voucherSelect(String vname) {
		return sql.selectOne("Voucher.voucherSelect", vname);
	}

	public int voucherBuy(VoucherBuyDTO voucherBuy) {
		return sql.insert("Voucher.voucherBuy", voucherBuy);
	}

	public List<VoucherDTO> myVoucherList(String mid) {
		return sql.selectList("Voucher.myVoucherList", mid);
	}

	public VoucherBuyDTO myVoucherView(String vnum) {
		return sql.selectOne("Voucher.myVoucherView", vnum);
	}
	
}
