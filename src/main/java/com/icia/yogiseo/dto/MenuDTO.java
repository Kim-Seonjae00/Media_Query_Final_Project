package com.icia.yogiseo.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MenuDTO {
	private int menunum;
	private String sid;
	private String menuname;
	private int menuprice;
	private String menudesc;
	private int menutime;
	private String menuimg;
	private MultipartFile menuimgfile;
	private String mcategory1;
	private String mcategory2;
	private String mcategory3;
	private int menuhit;
	
}
