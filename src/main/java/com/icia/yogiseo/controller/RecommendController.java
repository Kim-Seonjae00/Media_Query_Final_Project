package com.icia.yogiseo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.icia.yogiseo.dto.StoreDTO;
import com.icia.yogiseo.dto.TasteDTO;
import com.icia.yogiseo.service.RecommendService;

@Controller
public class RecommendController {

	private ModelAndView mav;
	
	@Autowired
	private RecommendService recommendService;
	
	// 오늘 뭐먹지 선호도 조사 화면 이동
	@RequestMapping(value="/preferencesearchform")
	public String preferenceSearchForm() {
		return "PreferenceSearch";
	}
	
	// 오늘 뭐먹지 선호도 조사 후 처리
	@RequestMapping(value="/preferencesearch")
	public ModelAndView preferenceSearch(@ModelAttribute TasteDTO taste) {
		mav = recommendService.preferenceSearch(taste);
		return mav;
	}
	
	// 꿀조합  데이터 요청
	@RequestMapping(value="honeycombo")
	public ModelAndView honeyCombo(@RequestParam("hmainmenu") String hmainmenu,@RequestParam("onum") String onum,@RequestParam("sid") String sid) {
		mav = recommendService.honeyCombo(hmainmenu,onum,sid);
		return mav;
	}
	
	// 맛집 추천 화면 이동
	@RequestMapping(value="/recommendlist")
	public ModelAndView recommendList() {
		mav = recommendService.recommendList();
		return mav;
	}
	
	// 맛집(matcategory) 리스트 데이터 요청
	@RequestMapping(value="/recommendstorelist")
	public ModelAndView recommendStoreList(@ModelAttribute StoreDTO store,@RequestParam("title") String title) {
		mav = recommendService.recommendStoreList(store, title);
		return mav;
	}
	
}
