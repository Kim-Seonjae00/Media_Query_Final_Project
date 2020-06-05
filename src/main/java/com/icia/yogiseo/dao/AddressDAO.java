package com.icia.yogiseo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.yogiseo.dto.AddressDTO;

@Repository
public class AddressDAO {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	public List<AddressDTO> myAddressList(String mid) {
		return sql.selectList("Address.myAddressList", mid);
	}
	
	public int addressAdd(AddressDTO address) {
		return sql.insert("Address.addressAdd", address);
	}
	
	public int changeAll(String mid) {
		return sql.update("Address.changeAll", mid);
	}
	
	public int addressPick(int anum) {
		return sql.update("Address.addressPick", anum);
	}

	public int addressDelete(int anum) {
		return sql.delete("Address.addressDelete", anum);
	}
	public int addressCount(String mid) {
		return sql.selectOne("Address.addressCount", mid);
	}

	

	
	
}
