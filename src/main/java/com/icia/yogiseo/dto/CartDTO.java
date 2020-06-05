package com.icia.yogiseo.dto;

import lombok.Data;

@Data
public class CartDTO {
	private int cnum;
	private String mid;
	private String sid;
	private String storename;
	private int menunum;
	private String menuname;
	private int menuprice;
	private int camount;
}