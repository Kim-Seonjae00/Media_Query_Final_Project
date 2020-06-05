package com.icia.yogiseo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dao.AddressDAO;
import com.icia.yogiseo.dao.MemberDAO;
import com.icia.yogiseo.dao.OrdersDAO;
import com.icia.yogiseo.dao.RecommendDAO;
import com.icia.yogiseo.dao.StoreDAO;
import com.icia.yogiseo.dto.HoneyComboDTO;
import com.icia.yogiseo.dto.MemberDTO;
import com.icia.yogiseo.dto.OrdersDTO;
import com.icia.yogiseo.dto.RateDTO;
import com.icia.yogiseo.dto.RecommendResultDTO;
import com.icia.yogiseo.dto.ReviewDTO;
import com.icia.yogiseo.dto.StoreDTO;
import com.icia.yogiseo.dto.TasteDTO;

@Service
public class RecommendService {
	
	private ModelAndView mav;
	
	@Autowired
	private RecommendDAO recommendDAO;
	
	@Autowired
	private OrdersDAO ordersDAO;
	
	@Autowired
	private StoreDAO storeDAO;

	// 오늘 뭐먹지 선호도 조사 후 처리
	public ModelAndView preferenceSearch(TasteDTO taste) {
		mav = new ModelAndView();
		
		List<RecommendResultDTO> taste1List = recommendDAO.searchTaste1(taste);
		List<RecommendResultDTO> taste2List = recommendDAO.searchTaste2(taste);
		List<RecommendResultDTO> taste3List = recommendDAO.searchTaste3(taste);
		List<RecommendResultDTO> taste4List = recommendDAO.searchTaste4(taste); 
		
		List<RecommendResultDTO> tasteList = new ArrayList<RecommendResultDTO>();
		tasteList.addAll(taste1List);
		tasteList.addAll(taste2List);
		tasteList.addAll(taste3List);
		tasteList.addAll(taste4List);
		
		for(int i=0;i<tasteList.size();i++) {
			for(int j=1;j<tasteList.size();j++) {				
				if(tasteList.get(i).getMenuname().contains(tasteList.get(j).getMenuname())) {
					if(tasteList.get(i).getStorename().contains(tasteList.get(j).getStorename())) {
						tasteList.remove(j);
					}
				}
			}
		}
		
		if(taste1List == null && taste2List == null && taste3List == null) {
			mav.setViewName("NoResult");
		} else {
			mav.addObject("tasteList", tasteList);
			mav.setViewName("FoodPreferenceResult");
		}
		
		return mav;
	}


	// 꿀조합 데이터 요청
	public ModelAndView honeyCombo(String hmainmenu, String onum, String sid) {
		mav = new ModelAndView();
		
		List<String> honeyCombo = recommendDAO.honeyCombo(hmainmenu);
		List<OrdersDTO> ordersList = ordersDAO.orderGet(onum);
		
		
		int[] orderCount = new int[honeyCombo.size()];
		for(int i=0;i<honeyCombo.size();i++) {
			HoneyComboDTO honey = new HoneyComboDTO();
			honey.setHmainmenu("%"+hmainmenu+"%");
			honey.setHmenu("%"+honeyCombo.get(i)+"%");
			int orders = recommendDAO.ordersCount(honey);
			orderCount[i] = orders;
		}
		
		int otime = ordersList.get(0).getOtime();
		
		mav.addObject("orderCount", orderCount);
		mav.addObject("otime", otime);
		mav.addObject("honeyCombo", honeyCombo);
		mav.setViewName("HoneyCombo");
		return mav;
	}

	// 맛집 추천 화면 이동
		public ModelAndView recommendList() {
			mav = new ModelAndView();
			
			// 바우처가 있는 식당 sid 리스트 조회
			List<String> storeNameList = recommendDAO.storeNameList();
			List<StoreDTO> storeList = new ArrayList<StoreDTO>();
				
			// 바우처가 있는 식당 storeDTO 리스트
			for(int i=0;i<storeNameList.size();i++) {
				String sid = storeNameList.get(i);
				StoreDTO store = new StoreDTO();
				store = recommendDAO.voucherStoreList(sid);
				storeList.add(store);
			}
			
			// 바우처가 있는 식당 평점 조회
			double[] rrateList = new double[storeNameList.size()];
			for(int i=0;i<storeNameList.size();i++) {
				String sid = storeNameList.get(i);
				double rrate = recommendDAO.getRrate(sid);
				rrateList[i] = rrate;
			}
			
			// 평점 높은 식당 리스트 조회
			List<RateDTO> rateList = recommendDAO.rateList();
			List<StoreDTO> sList = recommendDAO.sList();
			List<StoreDTO> bestList = new ArrayList<StoreDTO>();
			
			for(int i=0;i<rateList.size();i++) {
				for(int j=0;j<sList.size();j++) {
					if(rateList.get(i).getSid().equals(sList.get(j).getSid())) {
						StoreDTO store = sList.get(j);
						bestList.add(store);
					}
				}
			}
			
			double[] rates = new double[bestList.size()];
			for(int i=0;i<bestList.size();i++) {
				String sid = bestList.get(i).getSid();
				double rrate = recommendDAO.getRrate(sid);
				rates[i] = rrate;
			}
			
			mav.addObject("rates", rates);
			mav.addObject("bestList", bestList);
			mav.addObject("rrateList", rrateList);
			mav.addObject("storeList", storeList);
			mav.setViewName("RecommendList");
			
			return mav;
		}
		
		// 맛집(matcategory) 리스트 데이터 요청
		public ModelAndView recommendStoreList(StoreDTO store, String title) {
			mav = new ModelAndView();
			
			List<StoreDTO> storeList = recommendDAO.recommendStoreList(store);
			
			// 식당 평점 조회
			double[] rrateList = new double[storeList.size()];
			for(int i=0;i<storeList.size();i++) {
				String sid = storeList.get(i).getSid();
				double rrate = recommendDAO.getRrate(sid);
				rrateList[i] = rrate;
			}
			
			// 식당 리뷰 조회
			List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
			for(int i=0;i<storeList.size();i++) {
				String sid = storeList.get(i).getSid();
				ReviewDTO review = recommendDAO.getReview(sid);
				reviewList.add(review);
			}
			
			// 회원 프로필사진 조회
			List<String> imgList = new ArrayList<String>();
			for(int i=0;i<reviewList.size();i++) {
				String mid = reviewList.get(i).getMid();
				String mimg = recommendDAO.getMimg(mid);
				imgList.add(mimg);
			}
			
			mav.addObject("imgList", imgList);
			mav.addObject("reviewList", reviewList);
			mav.addObject("rrateList", rrateList);
			mav.addObject("title", title);
			mav.addObject("storeList", storeList);
			mav.setViewName("RecommendStoreList");
			
			return mav;
		}
}
