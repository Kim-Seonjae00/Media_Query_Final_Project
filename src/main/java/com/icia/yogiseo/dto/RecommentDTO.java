package com.icia.yogiseo.dto;

import lombok.Data;

@Data
public class RecommentDTO {
	private int rcnum;
	private String sid;
	private int rnum;
	private String rccontents;
	private String rcdate;
}
