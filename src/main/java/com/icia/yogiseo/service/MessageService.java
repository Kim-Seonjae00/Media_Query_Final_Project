package com.icia.yogiseo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dao.MemberDAO;
import com.icia.yogiseo.dao.MessageDAO;
import com.icia.yogiseo.dao.StoreDAO;
import com.icia.yogiseo.dto.MemberDTO;
import com.icia.yogiseo.dto.MessageDTO;
import com.icia.yogiseo.dto.SenderDTO;
import com.icia.yogiseo.dto.StoreDTO;


@Service
public class MessageService {

	private ModelAndView mav;
	
	@Autowired
	private MessageDAO messageDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private StoreDAO storeDAO;
	
	//채팅방 목록 조회
	public ModelAndView chattingRoom(String loginId) {
		mav = new ModelAndView();
		
		//나에게 메시지 보낸 사람들 리스트
		List<String> msenderList = messageDAO.msenderList(loginId);
		List<String> resultList = new ArrayList<String>();
		List<SenderDTO> senderList = new ArrayList<SenderDTO>();
		List<Integer> malertList = new ArrayList<Integer>();
		List<MessageDTO> messageList = new ArrayList<MessageDTO>();
		
		for(int i=0;i<msenderList.size();i++) {
			if(!resultList.contains(msenderList.get(i))){
				resultList.add(msenderList.get(i));
			}
		}
		
		
		for(int i=0; i<resultList.size(); i++) {
			SenderDTO sender = new SenderDTO();
			String senderid = resultList.get(i);
			MessageDTO messageName = new MessageDTO();
			messageName.setMsender(resultList.get(i));
			messageName.setMreceiver(loginId);
			int storeCount = storeDAO.storeCount1(senderid);
			if(storeCount > 0) {
				sender = storeDAO.storeNameList(senderid);
			}else {
				sender = memberDAO.memberNameList(senderid);
			}
			
			senderList.add(sender);	
			int malert = messageDAO.malertCount(senderid);
			malertList.add(malert);
			
			MessageDTO message = messageDAO.getRecently(messageName);
			messageList.add(message);
		}
		
		mav.addObject("senderList", senderList);
		mav.addObject("malertList", malertList);
		mav.addObject("messageList", messageList);
//		mav.addObject("msenderList", msenderList);
		mav.setViewName("ChattingRoom");
		
		return mav;
	}
	
	//메시지 조회
	public ModelAndView messageList(MessageDTO message, SenderDTO sender) {
		mav = new ModelAndView();
		List<MessageDTO> messageList = messageDAO.messageList(message);
		String mreceiver = message.getMreceiver();
//		StoreDTO storeView = storeDAO.storeView(mreceiver);
		
		messageDAO.alertUpdate(mreceiver);
		
//		mav.addObject("store", storeView);
		mav.addObject("sender", sender);
		mav.addObject("messageList", messageList);
		mav.setViewName("MessageForm");
		
		return mav;
	}
	
	
	//메시지 보내기
	public List<MessageDTO> addMessage(MessageDTO message) {
		int addResult = messageDAO.addMessage(message);
		List<MessageDTO> messageList = new ArrayList<MessageDTO>();
		if(addResult > 0) {
			messageList = messageDAO.messageList(message);
		}else {
			messageList = null;
		}
		
		return messageList;
	}

	//갱신할 채팅 내용만을 출력하는 용도
	public List<MessageDTO> getMessage(MessageDTO message) {
		List<MessageDTO> messageList = messageDAO.messageList(message);
		
		return messageList;
	}

	//안읽은 메시지 개수 조회
	public String messageCount(String mreceiver) {
		int result = messageDAO.messageCount(mreceiver);
		
		String resultMsg = null;
		if(result > 0) {
			resultMsg = "YES";
		}else {
			resultMsg = "NO";
		}
		
		return resultMsg;
	}




	
	
	
	
}
