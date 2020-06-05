package com.icia.yogiseo.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class StoreDTO {
	private String sid;
	private String spassword;
	private String sname;
	private String snumber;
	private String storename;
	private String sphone;
	private String spostcode;
	private String sadrs1;
	private String sadrs2;
	private String sadrs3;
	private String sadrs4;
	private String simg;
	private MultipartFile simgfile;
	private String scategory;
	private int sales;
	private int running;
	private int sblock;
	private String matcategory;
}
