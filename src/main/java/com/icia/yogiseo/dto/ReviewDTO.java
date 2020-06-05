package com.icia.yogiseo.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ReviewDTO {
	private int rnum;
	private String mid;
	private String sid;
	private String onum;
	private String rcontents;
	private String rimg;
	private MultipartFile rimgfile;
	private double rrate;
	private String rdate;
	private int rhit;
	private int rreport;
}
