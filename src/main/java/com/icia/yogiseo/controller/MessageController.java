package com.icia.yogiseo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dto.MessageDTO;
import com.icia.yogiseo.dto.SenderDTO;
import com.icia.yogiseo.service.MessageService;

@Controller
public class MessageController {
	
	@Autowired
	private MessageService messageService;
	
	private ModelAndView mav;
	 
	private List<MessageDTO> message;
	
	MessageController(){
		message = new ArrayList<MessageDTO>();
	}
	
	//채팅방 목록
	@RequestMapping(value="/chattingroom")
	public ModelAndView chattingRoom(@RequestParam("loginId") String loginId) {
		mav = messageService.chattingRoom(loginId);
		
		return mav;
	}
	
	//메시지  조회
	@RequestMapping(value="/messagelist")
	public ModelAndView messageList(@ModelAttribute MessageDTO message, @ModelAttribute SenderDTO sender) {
		sender.setSenderid(message.getMreceiver());
		mav = messageService.messageList(message, sender);
		
		return mav;
	}
	
//	@RequestMapping(value="/addMessage")
//	@ResponseBody
//	public Map<String, Object> doAddMessage(String msender, String mcontents) {
//		int mnum = message.size(); //저장된 마지막 메시지의 다음 번호
//		MessageDTO newChatMessage = new MessageDTO(mnum, msender, mcontents);
//		
//		message.add(newChatMessage);
//		
//		//ajax가 가져갈 출력값 객체 생성
//		Map<String, Object> rs = new HashMap<String, Object>();
//		
//		rs.put("msg", "메시지가 전송되었습니다.");
//		
//		return rs;
//	}
	
	//1:1문의 메시지폼 불러오기
	@RequestMapping(value="/messageadmin")
	public String messageAdmin() {
		
		return "MessageAdminForm";
	}
	
	//메시지 보내기
	@RequestMapping(value="/addMessage")
	public @ResponseBody List<MessageDTO> addMessage(@ModelAttribute MessageDTO message) {
		List<MessageDTO> messageList = messageService.addMessage(message);
		return messageList;
	}
	
	//갱신할 채팅 내용만을 출력하는 용도
	@RequestMapping("/getMessage")
	public @ResponseBody List<MessageDTO> getMessage(@ModelAttribute MessageDTO message) {
		List<MessageDTO> massageList = messageService.getMessage(message);
		return massageList;
	}
	
	//안읽은 메시지 개수 조회
	@RequestMapping("/messagecount")
	public @ResponseBody String messageCount(@RequestParam("mreceiver") String mreceiver) {
		String resultMsg = messageService.messageCount(mreceiver);
		
		return resultMsg;
	}
	
	
	
	
}
