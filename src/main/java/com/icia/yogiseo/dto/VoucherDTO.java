package com.icia.yogiseo.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class VoucherDTO {
	private String vnum;
	private String storename;
	private String sid;
	private String vname;
	private int vprice;
	private String vdate;
	private String vimg;
	private MultipartFile vimgfile;
	private int vcount;
}
