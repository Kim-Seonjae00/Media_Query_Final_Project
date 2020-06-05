package com.icia.yogiseo.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dao.MemberDAO;
import com.icia.yogiseo.dao.NoticeDAO;
import com.icia.yogiseo.dto.MemberDTO;
import com.icia.yogiseo.dto.NoticeDTO;
import com.icia.yogiseo.dto.PagingDTO;

@Service
public class NoticeService {
	
	private ModelAndView mav;
	
	@Autowired
	private NoticeDAO noticeDAO;
	
	@Autowired
	private MemberDAO memberDAO;

	// 관리자 공지사항 리스트 조회
	public ModelAndView adminNoticeList(String loginId, PagingDTO paging) {
		mav = new ModelAndView();
		
		int page=1;
    	int limit=5;
    	
    	if(paging.getPage() != 0) {
    		page = paging.getPage();
    	}
    	
    	int listcount = noticeDAO.listCount();
    	
    	int startrow = (page - 1)*limit + 1;
    	int endrow = page* limit;
    	
    	paging.setStartrow(startrow);
    	paging.setEndrow(endrow);
    	
    	List<NoticeDTO> noticeList = noticeDAO.adminNoticeList(paging);
    	int maxPage = (int) ((double) listcount / limit + 0.9);
    	
    	int startPage = (((int) ((double) page / 10 + 0.9)) -1) * 10 + 1;
    	
    	int endPage = startPage + 10 - 1;
    	
    	if(endPage > maxPage) {
    		endPage = maxPage;
    	}
    	
    	paging.setPage(page);
    	paging.setListcount(listcount);
    	
    	
		MemberDTO profile = memberDAO.myProfile(loginId);
		
		mav.addObject("paging", paging);
		mav.addObject("noticeList", noticeList);
		mav.addObject("profile", profile);
		mav.setViewName("admin/AdminNoticeList");
		return mav;
	}
	
	// 관리자 공지사항 작성 화면 이동
		public ModelAndView noticeForm(String loginId) {
			mav = new ModelAndView();
			
			MemberDTO profile = memberDAO.myProfile(loginId);
			
			mav.addObject("profile", profile);
			mav.setViewName("admin/NoticeForm");
			
			return mav;
		}

	// 관리자 공지사항 작성 처리
	public ModelAndView noticeWrite(NoticeDTO notice, String loginId) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		
		MultipartFile nfilefile = notice.getNfilefile();
		String nfile = nfilefile.getOriginalFilename();
		
		String savePath = "C:\\Users\\4\\Desktop\\Development\\Source\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\notice\\"+nfile;
		if(!nfilefile.isEmpty()) {
			nfilefile.transferTo(new File(savePath));
		}
		notice.setNfile(nfile);
		
		
		int writeResult = noticeDAO.noticeWrite(notice);
		if(writeResult>0) {
			mav.setViewName("redirect:/adminnoticelist?loginId="+loginId);
		} else {
			mav.setViewName("Fail");
		}
		
		return mav;
	}

	// 관리자 공지사항 상세보기
	public ModelAndView adminNoticeView(int nnum, String loginId) throws IOException {
		mav = new ModelAndView();
		
		NoticeDTO notice = noticeDAO.adminNoticeView(nnum);
		MemberDTO profile = memberDAO.myProfile(loginId);
		
		Path source = Paths.get("C:\\Users\\4\\Desktop\\Development\\Source\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\notice\\"+notice.getNfile());
	    String mimeType = Files.probeContentType(source);
	    if(mimeType.contains("image")) {
	    	notice.setNfiletype("이미지");
	    } else {
	    	notice.setNfiletype("자료");
	    }
		
		mav.addObject("profile", profile);
		mav.addObject("notice", notice);
		mav.setViewName("admin/AdminNoticeView");
		
		return mav;
	}

	// 관리자 공지사항 수정 데이터 요청
	public ModelAndView noticeModifySelect(int nnum, String loginId) {
		mav = new ModelAndView();
		
		NoticeDTO notice = noticeDAO.adminNoticeView(nnum);
		MemberDTO profile = memberDAO.myProfile(loginId);
		
		mav.addObject("profile", profile);
		mav.addObject("notice", notice);
		mav.setViewName("admin/NoticeModify");
		return mav;
	}
	
	// 관리자 공지사항 수정 처리
	public ModelAndView noticeModifySelect(NoticeDTO notice, String loginId) throws IllegalStateException, IOException {
		mav = new ModelAndView();
		
		MultipartFile nfilefile = notice.getNfilefile();
		String nfile = nfilefile.getOriginalFilename();
		
		String savePath = "C:\\Users\\4\\Desktop\\Development\\Source\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\notice\\"+nfile;
		if(!nfilefile.isEmpty()) {
			nfilefile.transferTo(new File(savePath));
		}
		notice.setNfile(nfile);
		
		int updateResult = noticeDAO.noticeModify(notice);
		if(updateResult == 1) {
			mav.setViewName("redirect:/adminnoticelist?loginId="+loginId);
		} else {
			mav.setViewName("Fail");
		}
		
		return mav;
	}

	// 관리자 공지사항 삭제처리
	public ModelAndView noticeDelete(int nnum, String loginId) {
		mav = new ModelAndView();
		
		int deleteResult = noticeDAO.noticeDelete(nnum);
		if(deleteResult == 1) {
			mav.setViewName("redirect:/adminnoticelist?loginId="+loginId);
		} else {
			mav.setViewName("Fail");
		}
		
		return mav;
	}

	// 회원 공지사항 리스트 조회(ajax)
	public List<NoticeDTO> noticeListAjax(PagingDTO paging) {
		
		int page=1;
    	int limit=5;
    	
    	if(paging.getPage() != 0) {
    		page = paging.getPage();
    	}
    	
    	int listcount = noticeDAO.listCount();
    	
    	int startrow = (page - 1)*limit + 1;
    	int endrow = page* limit;
    	
    	paging.setStartrow(startrow);
    	paging.setEndrow(endrow);
    	
    	List<NoticeDTO> noticeList = noticeDAO.adminNoticeList(paging);
    	int maxPage = (int) ((double) listcount / limit + 0.9);
    	
    	int startPage = (((int) ((double) page / 10 + 0.9)) -1) * 10 + 1;
    	
    	int endPage = startPage + 10 - 1;
    	
    	if(endPage > maxPage) {
    		endPage = maxPage;
    	}
    	
    	paging.setPage(page);
    	paging.setListcount(listcount);
    	
		return noticeList;
	}
	
	// 공지사항 리스트 조회(첫화면)
	public ModelAndView noticeList(PagingDTO paging) {
		mav = new ModelAndView();
	
		int page=1;
    	int limit=5;
    	
    	if(paging.getPage() != 0) {
    		page = paging.getPage();
    	}
    	
    	int listcount = noticeDAO.listCount();
    	
    	int startrow = (page - 1)*limit + 1;
    	int endrow = page* limit;
    	
    	paging.setStartrow(startrow);
    	paging.setEndrow(endrow);
    	
    	List<NoticeDTO> noticeList = noticeDAO.adminNoticeList(paging);
    	int maxPage = (int) ((double) listcount / limit + 0.9);
    	
    	int startPage = (((int) ((double) page / 10 + 0.9)) -1) * 10 + 1;
    	
    	int endPage = startPage + 10 - 1;
    	
    	if(endPage > maxPage) {
    		endPage = maxPage;
    	}
    	
    	paging.setPage(page);
    	paging.setListcount(listcount);
    	
    	mav.addObject("paging", paging);
    	mav.addObject("noticeList", noticeList);
    	mav.setViewName("NoticeList");
    	
		return mav;
	}


	// 회원 공지사항 상세조회
	public ModelAndView noticeView(int nnum) throws IOException {
		mav = new ModelAndView();
		
		NoticeDTO notice = noticeDAO.adminNoticeView(nnum);
		
		Path source = Paths.get("C:\\\\Users\\10\\Desktop\\develporent\\souce\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\notice\\"+notice.getNfile());
	    String mimeType = Files.probeContentType(source);
	    if(mimeType.contains("image")) {
	    	notice.setNfiletype("이미지");
	    } else {
	    	notice.setNfiletype("자료");
	    }

		mav.addObject("notice", notice);
		mav.setViewName("NoticeView");
	
		return mav;
	}

	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
