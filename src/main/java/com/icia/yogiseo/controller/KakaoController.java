package com.icia.yogiseo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class KakaoController {

	
	@RequestMapping(value="/kakaomap")
	public String kakaoMap() {
		
		return "KakaoMap";
	}
}
