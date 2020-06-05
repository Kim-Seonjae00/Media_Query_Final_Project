package com.icia.yogiseo.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeDTO {
	private int nnum;
	private String nid;
	private String ntitle;
	private String ncontents;
	private String ndate;
	private String nfile;
	private MultipartFile nfilefile;
	private String nfiletype;
}
