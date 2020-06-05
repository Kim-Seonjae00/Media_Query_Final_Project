package com.icia.yogiseo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.yogiseo.dto.MessageDTO;
import com.icia.yogiseo.dto.StoreDTO;

@Repository
public class MessageDAO {
	
	@Autowired
	private SqlSessionTemplate sql;

	public List<String> msenderList(String loginId) {
		return sql.selectList("Message.msenderList", loginId);
	}

	public List<MessageDTO> messageList(MessageDTO message) {
		return sql.selectList("Message.messageList", message);
	}
	
	public int addMessage(MessageDTO message) {
		return sql.insert("Message.addMessage", message);
	}

	public int malertCount(String msender) {
		return sql.selectOne("Message.malertCount", msender);
	}

	public int alertUpdate(String mreceiver) {
		return sql.update("Message.alertUpdate", mreceiver);
	}

	public MessageDTO getRecently(MessageDTO messageName) {
		return sql.selectOne("Message.getRecently", messageName);				
	}
	
	public int messageCount(String mreceiver) {
		return sql.selectOne("Message.messageCount", mreceiver);
	}
	
	public void sendOrdersPay(MessageDTO message) {
		sql.insert("Message.sendOrdersPay", message);
	}


	
	
	

	

	



	
	
	
	
}
