package com.icia.yogiseo.dto;

import lombok.Data;

@Data
public class OrdersDTO {
	private String onum;
	private String mid;
	private String sid;
	private String storename;
	private int menunum;
	private String menuname;
	private int menuprice;
	private int camount;
	private int ototalprice;
	private String odate;
	private String ostatus;
	private String opayway;
	private String oaddress;
	private String omessage;
	private int otime;
}
