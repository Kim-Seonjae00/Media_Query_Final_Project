package com.icia.yogiseo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.icia.yogiseo.dao.MessageDAO;
import com.icia.yogiseo.dao.OrdersDAO;
import com.icia.yogiseo.dto.MessageDTO;
import com.icia.yogiseo.dto.OrdersDTO;

@Service("asyncTaskService")
public class AsyncTaskService {
	@Autowired
	private OrdersDAO ordersDAO;
	
	@Autowired
	private MessageDAO messageDAO;
	
	@Async
	public void jobRunningInBackground(String onum) {
		int menutime= ordersDAO.getMaxMenutime(onum);
		OrdersDTO orders = ordersDAO.getOrders(onum);
		System.out.println("Thread시작");
		for(int i=0; i < menutime; i++) {
			try {
				Thread.sleep(60000);
				System.out.println("first"+i);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		orders.setOstatus("배달중");
		ordersDAO.updateOrdersStatus(orders);
		System.out.println("배달중");
		MessageDTO message = new MessageDTO();
		List<OrdersDTO> ordersList = ordersDAO.orderGet(onum);
		message.setMreceiver(orders.getMid());
		message.setMsender(orders.getSid());
		if(ordersList.size()==1) {
			message.setMcontents(orders.getMenuname()+"이(가) 출발하였습니다.");
		}else {
			message.setMcontents(orders.getMenuname()+"외 "+(ordersList.size()-1)+"건이 출발하였습니다.");
		}
		messageDAO.sendOrdersPay(message);
		
		
		int otime = orders.getOtime();
		int deliveryTime = otime-menutime+5;
		for(int i=0; i < deliveryTime; i++) {
			try {
				Thread.sleep(60000);
				System.out.println("second"+i);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		if(ordersList.size()==1) {
			message.setMcontents(orders.getMenuname()+"이(가) 배달완료되었습니다.");
		}else {
			message.setMcontents(orders.getMenuname()+"외 "+(ordersList.size()-1)+"건이 배달완료되었습니다.");
		}
		messageDAO.sendOrdersPay(message);
		
		orders.setOstatus("배달완료");
		System.out.println("배달완료");
		ordersDAO.updateOrdersStatus(orders);
	}
}