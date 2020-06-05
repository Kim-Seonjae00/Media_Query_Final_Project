package com.icia.yogiseo.service;

import java.io.File;
import java.io.IOException;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dao.MemberDAO;
import com.icia.yogiseo.dao.OrdersDAO;
import com.icia.yogiseo.dao.RecommentDAO;
import com.icia.yogiseo.dao.ReviewDAO;
import com.icia.yogiseo.dto.MemberDTO;
import com.icia.yogiseo.dto.RecommentDTO;
import com.icia.yogiseo.dto.ReviewDTO;
import com.icia.yogiseo.dto.ReviewJoinRecommentDTO;
import com.icia.yogiseo.dto.ReviewRecommendDTO;
import com.icia.yogiseo.dto.ReviewReportDTO;
import com.icia.yogiseo.dto.SearchDTO;

@Service
public class ReviewService {

	private ModelAndView mav;
	
	@Autowired
	private ReviewDAO reviewDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private OrdersDAO ordersDAO;
	
	@Autowired
	private RecommentDAO recommentDAO;
	
	private static final int PAGE_LIMIT=5;

	//리뷰 작성 처리
	public ModelAndView reviewWrite(ReviewDTO review) throws IllegalStateException, IOException {
		mav = new ModelAndView();

		MultipartFile rFiles = review.getRimgfile();
		String rFilesname = rFiles.getOriginalFilename();
		String savePath = "C:\\Users\\4\\Desktop\\Development\\Source\\servlet\\YogiseoYogi\\src\\main\\webapp\\resources\\img\\review\\"+rFilesname;
		if(!rFiles.isEmpty()) {
			rFiles.transferTo(new File(savePath));
		}
		
		review.setRimg(rFilesname);
		System.out.println(review);
		System.out.println(review.getRimg());
		int reviewWriteResult = reviewDAO.reviewWrite(review);
		if(reviewWriteResult==1) {
			String mid = review.getMid();
			mav.setViewName("redirect:/myreviewlist?mid="+mid);
		}else {
			mav.setViewName("Fail");
		}
		return mav;
	}

	//리뷰 리스트
	public List<ReviewJoinRecommentDTO> reviewList(SearchDTO search, String sid) {
		int page=1;
		if(search.getPage()!=0) {
			page = search.getPage();
		}
		
		int startRow = (page-1)*PAGE_LIMIT+1;
		int endRow = page*PAGE_LIMIT;

		search.setStartRow(startRow);
		search.setEndRow(endRow);
		
		List<Integer> rnumList = reviewDAO.rnumList(search);
		List<Integer> recommentRnumList = reviewDAO.recommentRnumList();
		
		
		List<ReviewJoinRecommentDTO> reviewList = new ArrayList<ReviewJoinRecommentDTO>();
		
		for(int i=0;i<rnumList.size();i++) {
			boolean overlap = false;
			for(int j=0;j<recommentRnumList.size();j++) {
				if(rnumList.get(i)==recommentRnumList.get(j)) {
					overlap = true;
					break;
				}else {
					overlap=false;
				}
			}
			
			List<String> midList = reviewDAO.recommendMidList(rnumList.get(i));
			
			ReviewJoinRecommentDTO reviewRecomment = new ReviewJoinRecommentDTO();
			if(overlap) {
				reviewRecomment = reviewDAO.reviewRecommentList(rnumList.get(i));
			}else {
				ReviewDTO review = reviewDAO.reviewList(rnumList.get(i));
				reviewRecomment.setRnum(review.getRnum());
				reviewRecomment.setSid(review.getSid());
				reviewRecomment.setMid(review.getMid());
				reviewRecomment.setOnum(review.getOnum());
				reviewRecomment.setRcontents(review.getRcontents());
				reviewRecomment.setRimg(review.getRimg());
				reviewRecomment.setRrate(review.getRrate());
				reviewRecomment.setRdate(review.getRdate());
				reviewRecomment.setRhit(review.getRhit());
				reviewRecomment.setRreport(review.getRreport());
			}
			
			reviewRecomment.setRecommend(midList.contains(sid));
			
			reviewList.add(reviewRecomment);
		}
		return reviewList;
	}

	// 관리자 신고된 리뷰 리스트 조회
	public ModelAndView reportReviewList(String loginId) {
		mav = new ModelAndView();
		
		List<ReviewDTO> reportReviewList = new ArrayList<ReviewDTO>();
		reportReviewList = reviewDAO.reportReviewList();
		MemberDTO profile = memberDAO.myProfile(loginId);
		
		mav.addObject("profile", profile);
		mav.addObject("reportReviewList", reportReviewList);
		mav.setViewName("admin/ReportReviewList");
		
		return mav;
	}

	// 관리자 리뷰 삭제
	public ModelAndView adminReviewDelete(int rnum, String loginId) {
		mav = new ModelAndView();
		
		int deleteResult = reviewDAO.adminReviewDelete(rnum);
		if(deleteResult == 1) {
			mav.setViewName("redirect:/reportreviewlist?loginId="+loginId);
		} else {
			mav.setViewName("Fail");
		}
		
		return mav;
	}
	
	//회원마이페이지 기본 프로필 설정
	public ModelAndView memberProfile(String mid) {
		mav = new ModelAndView();

		MemberDTO member = memberDAO.memberView(mid);
		int count = memberDAO.couponCount(mid);
		int ordersCount = ordersDAO.ordersCount(mid); 

		mav.addObject("couponCount", count);
		mav.addObject("ordersCount", ordersCount);
		mav.addObject("member", member);

		return mav;
	}

	//내 리뷰 목록 조회
	public ModelAndView myReviewList(String mid) {
		mav = memberProfile(mid);

		List<ReviewDTO> review = reviewDAO.myReviewList(mid);

		mav.addObject("reviewList", review);
		mav.setViewName("member/MyReviewList");

		return mav;
	}

	public ModelAndView reviewDelete(int rnum, String mid) {
		mav = new ModelAndView();
		int deleteResult = reviewDAO.reviewDelete(rnum);
		
		if(deleteResult==1) {
			mav.setViewName("redirect:/myreviewlist?mid="+mid);
		}
		
		return mav;
	}

	public RecommentDTO reviewComment(RecommentDTO recomment) {
		int result = recommentDAO.reviewCommnet(recomment);
		RecommentDTO reviewCommentResult = null;
		if(result == 1) {
			reviewCommentResult = recommentDAO.recommentGet(recomment.getRnum());
		}
		
		return reviewCommentResult;
	}

	public String reviewRecommend(ReviewRecommendDTO reviewRecommend) {
		int result = reviewDAO.reviewRecommend(reviewRecommend);
		String recommendResult = "";
		if(result==1) {
			reviewDAO.plusRhit(reviewRecommend);
			recommendResult = "success";
		}
		return recommendResult;
	}

	public String recommendCancel(ReviewRecommendDTO reviewRecommend) {
		int result = reviewDAO.recommendCancel(reviewRecommend);
		String cancelResult = "";
		if(result == 1) {
			reviewDAO.minusRhit(reviewRecommend);
			cancelResult = "success";
		}
		
		return cancelResult;
	}

	public String reviewReport(ReviewReportDTO reviewReport) {
		String reportResult = "";
		System.out.println(reviewReport);
		if(reviewDAO.containReport(reviewReport)) {
			reportResult =  "overlap";
		}else {
			int result = reviewDAO.reviewReport(reviewReport);
			if(result==1) {
				reviewDAO.plusRreport(reviewReport);
				reportResult = "success";
			}
		}
		
		return reportResult;
	}
	
}
