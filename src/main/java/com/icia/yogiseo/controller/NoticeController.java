package com.icia.yogiseo.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dto.NoticeDTO;
import com.icia.yogiseo.dto.PagingDTO;
import com.icia.yogiseo.service.NoticeService;

@Controller
public class NoticeController {
	
	private ModelAndView mav;
	
	@Autowired
	private NoticeService noticeService;
	
	// 관리자 공지사항 작성 화면으로 이동
	@RequestMapping(value="/noticeform")
	public ModelAndView noticeform(@RequestParam("loginId") String loginId) {
		mav = noticeService.noticeForm(loginId);
		return mav;
	}
	
	// 관리자 공지사항 작성 처리
	@RequestMapping(value="/noticewrite")
	public ModelAndView noticeWrite(@ModelAttribute NoticeDTO notice, @RequestParam("loginId") String loginId) throws IllegalStateException, IOException {
		mav = noticeService.noticeWrite(notice, loginId);
		return mav;
	}
	
	// 관리자 공지사항 리스트 조회
	@RequestMapping(value="/adminnoticelist")
	public ModelAndView adminNoticeList(@RequestParam("loginId") String loginId, @ModelAttribute PagingDTO paging) {
		mav = noticeService.adminNoticeList(loginId, paging);
		return mav;
	}

	// 관리자 공지사항 상세조회
	@RequestMapping(value="/adminnoticeview")
	public ModelAndView adminNoticeView(@RequestParam("nnum") int nnum, @RequestParam("loginId") String loginId) throws IOException {
		mav = noticeService.adminNoticeView(nnum, loginId);
		return mav;
	}
	
	// 관리자 공지사항 수정 데이터 요청
	@RequestMapping(value="/noticemodifyselect")
	public ModelAndView noticeModifySelect(@RequestParam("nnum") int nnum, @RequestParam("loginId") String loginId) {
		mav = noticeService.noticeModifySelect(nnum, loginId);
		return mav;
	}
	
	// 관리자 공지사항 수정 처리
	@RequestMapping(value="/noticemodify")
	public ModelAndView noticeModify(@ModelAttribute NoticeDTO notice, @RequestParam("loginId") String loginId) throws IllegalStateException, IOException {
		mav = noticeService.noticeModifySelect(notice, loginId);
		return mav;
	}
	
	// 관리자 공지사항 삭제
	@RequestMapping(value="/noticedelete")
	public ModelAndView noticeDelete(@RequestParam("nnum") int nnum, @RequestParam("loginId") String loginId) {
		mav = noticeService.noticeDelete(nnum, loginId);
		return mav;
	}
	
	// 회원 공지사항 리스트 조회(ajax)
	@RequestMapping(value="/noticelistajax")
	public @ResponseBody List<NoticeDTO> noticeListAjax(@ModelAttribute PagingDTO paging) {
		List<NoticeDTO> noticeList = noticeService.noticeListAjax(paging);
		return noticeList;
	}
	
	// 회원 공지사항 리스트 조회
	@RequestMapping(value="/noticelist")
	public ModelAndView noticeList(@ModelAttribute PagingDTO paging) {
		mav = noticeService.noticeList(paging);
		return mav;
	}
	
	// 회원 공지사항 상세조회
	@RequestMapping(value="/noticeview")
	public ModelAndView noticeView(@RequestParam("nnum") int nnum) throws IOException {
		mav = noticeService.noticeView(nnum);
		return mav;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
