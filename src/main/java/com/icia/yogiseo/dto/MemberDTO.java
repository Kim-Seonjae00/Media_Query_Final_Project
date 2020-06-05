package com.icia.yogiseo.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberDTO {
	private String mid;
	private String naverid;
	private String kakaoid;
	private String mpassword;
	private String mname;
	private String memail;
	private String mphone;
	private String mnickname;
	private int mtotalprice;
	private String mgrade;
	private int mpoint;
	private MultipartFile mimgfile;
	private String mimg;
	private int mblock;
}