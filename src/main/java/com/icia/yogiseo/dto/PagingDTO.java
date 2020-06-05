package com.icia.yogiseo.dto;

import lombok.Data;

@Data
public class PagingDTO {
	
	private int page;
	private int listcount;
	private int startrow;
	private int endrow;
}
