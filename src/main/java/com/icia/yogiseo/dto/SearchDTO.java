package com.icia.yogiseo.dto;

import lombok.Data;

@Data
public class SearchDTO {
	private int page;
	private int listCount;
	private int startRow;
	private int endRow;
	private String scategory;
	private String sid;
	private String listname;
}
