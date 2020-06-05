package com.icia.yogiseo.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dto.RecommentDTO;
import com.icia.yogiseo.dto.ReviewDTO;
import com.icia.yogiseo.dto.ReviewJoinRecommentDTO;
import com.icia.yogiseo.dto.ReviewRecommendDTO;
import com.icia.yogiseo.dto.ReviewReportDTO;
import com.icia.yogiseo.dto.SearchDTO;
import com.icia.yogiseo.service.ReviewService;

@Controller
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	
	private ModelAndView mav;
	
	// 관리자 신고된 리뷰 리스트 조회
		@RequestMapping(value="/reportreviewlist")
		public ModelAndView reportReviewList(@RequestParam("loginId") String loginId) {
			mav = reviewService.reportReviewList(loginId);

			return mav;
		}
		
		// 관리자 신고된 리뷰 삭제
		@RequestMapping(value="/adminreviewdelete")
		public ModelAndView adminReviewDelete(@RequestParam("rnum") int rnum, @RequestParam("loginId") String loginId) {
			mav = reviewService.adminReviewDelete(rnum, loginId);
			return mav;
		}
		
		//리뷰작성
		@RequestMapping(value = "/reviewwrite")
		public ModelAndView reviewWrite(@ModelAttribute ReviewDTO review) throws IllegalStateException, IOException {
			mav = new ModelAndView();
			mav = reviewService.reviewWrite(review);

			return mav;
		}

		// 가게 리뷰 리스트 출력
		@RequestMapping(value="/reviewlist")
		public @ResponseBody List<ReviewJoinRecommentDTO> reviewList(@ModelAttribute SearchDTO search,@RequestParam("sid") String sid){
			List<ReviewJoinRecommentDTO> reviewList = reviewService.reviewList(search, sid);
			
			return reviewList;
		}
		
		//내 리뷰 목록 조회
		@RequestMapping(value="/myreviewlist")
		public ModelAndView myReviewList(@RequestParam("mid") String mid){
			mav = reviewService.myReviewList(mid);

			return mav;
		}
		
		//리뷰삭제
		@RequestMapping(value="/reviewdelete")
		public ModelAndView reviewDelete(@RequestParam("rnum") int rnum,@RequestParam("mid") String mid) {
			mav = reviewService.reviewDelete(rnum, mid);
			
			return mav;
		}
		
		//리뷰답글
		@RequestMapping(value="/reviewcomment")
		public @ResponseBody RecommentDTO reviewComment(@ModelAttribute RecommentDTO recomment) {
			RecommentDTO reviewCommentResult = reviewService.reviewComment(recomment);
			
			return reviewCommentResult;
		}
		
		@RequestMapping(value="/reviewrecommend")
		public @ResponseBody String reviewRecommend(@ModelAttribute ReviewRecommendDTO reviewRecommend) {
			String recommendResult = reviewService.reviewRecommend(reviewRecommend);
			
			return recommendResult;
		}
		
		@RequestMapping(value="/recommendcancel")
		public @ResponseBody String recommendCancel(@ModelAttribute ReviewRecommendDTO reviewRecommend) {
			String cancelResult = reviewService.recommendCancel(reviewRecommend);
			
			return cancelResult;
		}
		
		@RequestMapping(value="/reviewreport")
		public @ResponseBody String reviewReport(@ModelAttribute ReviewReportDTO reviewReport) {
			String cancelResult = reviewService.reviewReport(reviewReport);
			
			return cancelResult;
		}
}
