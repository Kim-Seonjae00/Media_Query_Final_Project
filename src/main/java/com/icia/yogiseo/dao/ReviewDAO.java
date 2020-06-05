package com.icia.yogiseo.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.icia.yogiseo.dto.ReviewDTO;
import com.icia.yogiseo.dto.ReviewJoinRecommentDTO;
import com.icia.yogiseo.dto.ReviewRecommendDTO;
import com.icia.yogiseo.dto.ReviewReportDTO;
import com.icia.yogiseo.dto.SearchDTO;

@Repository
public class ReviewDAO {
	
	@Autowired
	private SqlSessionTemplate sql;

	
	// 관리자 신고된 리뷰 리스트 조회
	public List<ReviewDTO> reportReviewList() {
		return sql.selectList("Review.reportReviewList");
	}

	// 관리자 신고된 리뷰 삭제
	public int adminReviewDelete(int rnum) {
		return sql.delete("Review.adminReviewDelete", rnum);
	}

	// 관리자 해당 회원 리뷰 리스트 조회
	public List<ReviewDTO> memberReviewList(String mid) {
		return sql.selectList("Review.memberReviewList", mid);
	}
	
	// 관리자 해당 업체 평점 조회
	public double storeRrate(String sid) {
		double rrate=sql.selectOne("Review.storeRrate", sid);
		System.out.println(rrate);
		return 5;
	}
	
	public ReviewJoinRecommentDTO reviewRecommentList(int rnum) {
		return sql.selectOne("Review.reviewRecommentList", rnum);
	}

	public int reviewWrite(ReviewDTO review) {
		return sql.insert("Review.reviewWrite", review);
	}

	public int reviewCount(String sid) {
		return sql.selectOne("Review.reviewCount", sid);
	}

	public float reviewRate(String sid) {
		return sql.selectOne("Review.reviewRate",sid);
	}

	public void firstReviewWrite(String sid) {
		sql.insert("Review.firstReviewWrite", sid);
	}
	
	public List<ReviewDTO> myReviewList(String mid) {
		return sql.selectList("Review.myReviewList", mid);
	}

	public List<ReviewDTO> storeReviewList(String sid) {
		return sql.selectList("Review.storeReviewList", sid);
	}

	public int reviewDelete(int rnum) {
		return sql.delete("Review.reviewDelete", rnum);
	}

	public List<Integer> rnumList(SearchDTO search) {
		return sql.selectList("Review.rnumList",search);
	}

	public List<Integer> recommentRnumList() {
		return sql.selectList("Review.recommentRnumList");
	}

	public ReviewDTO reviewList(int rnum) {
		return sql.selectOne("Review.reviewList", rnum);
	}

	public int reviewRecommend(ReviewRecommendDTO reviewRecommend) {
		return sql.insert("Review.reviewRecommend", reviewRecommend);
	}

	public void plusRhit(ReviewRecommendDTO reviewRecommend) {
		sql.update("Review.plusRhit", reviewRecommend);
	}

	public int recommendCancel(ReviewRecommendDTO reviewRecommend) {
		return sql.delete("Review.recommendCancel", reviewRecommend);
	}

	public void minusRhit(ReviewRecommendDTO reviewRecommend) {
		sql.update("Review.minusRhit", reviewRecommend);
	}

	public List<String> recommendMidList(int rnum) {
		return sql.selectList("Review.recommendMidList", rnum);
	}

	public boolean containReport(ReviewReportDTO reviewReport) {
		int count = sql.selectOne("Review.containReport", reviewReport);
		System.out.println(count);
		boolean result = false;
		if(count>0) {
			result = true;
		}
		
		return result;
	}

	public int reviewReport(ReviewReportDTO reviewReport) {
		return sql.insert("Review.reviewReport", reviewReport);
	}

	public void plusRreport(ReviewReportDTO reviewReport) {
		sql.update("Review.plusRreport",reviewReport);
	}
}
