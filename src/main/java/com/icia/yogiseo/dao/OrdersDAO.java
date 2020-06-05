package com.icia.yogiseo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.yogiseo.dto.OrdersDTO;

@Repository
public class OrdersDAO {
	
	@Autowired
	SqlSessionTemplate sql;

	public int ordersPay(OrdersDTO orders) {
		return sql.insert("Orders.ordersPay", orders);
	}


	public List<String> storeOnumList(String sid) {
		return sql.selectList("Orders.storeOnumList", sid);
	}


	public List<OrdersDTO> storeOrdersList(String onum) {
		return sql.selectList("Orders.storeOrdersList", onum);
	}


	public List<OrdersDTO> checkFirstOrder(String mid) {
		return sql.selectList("Orders.checkFirstOrder",mid);
	}


	public String getOnum(String mid) {
		return sql.selectOne("Orders.getOnum",mid);
	}


	public String getAddress(String onum) {
		return sql.selectOne("Orders.getAddress", onum);
	}


	public List<OrdersDTO> orderGet(String onum) {
		return sql.selectList("Orders.orderGet", onum);
	}
	
	public List<String> myOnumList(String mid) {
		return sql.selectList("Orders.myOnumList", mid);
	}

	public List<OrdersDTO> myOrdersList(String onum) {
		return sql.selectList("Orders.myOrdersList", onum);
	}
	
	public int ordersCount(String mid) {
		return sql.selectOne("Orders.ordersCount", mid);
	}


	public String ordersConfirm(String onum) {
		int result = sql.update("Orders.ordersConfirm", onum);
		String confirmResult = null;
		if(result>0) {
			confirmResult = "success";
		}
		return confirmResult;
	}


	public void ordersCancel(String onum) {
		sql.update("Orders.ordersCancel",onum);
	}


	public int getMaxMenutime(String onum) {
		return sql.selectOne("Orders.getMaxMenutime", onum);
	}


	public void updateOrdersStatus(OrdersDTO orders) {
		sql.update("Orders.updateOrdersStatus", orders);
	}


	public OrdersDTO getOrders(String onum) {
		List<OrdersDTO> ordersList = sql.selectList("Orders.getOrders",onum);
		
		return ordersList.get(0);
	}

	
	

}
