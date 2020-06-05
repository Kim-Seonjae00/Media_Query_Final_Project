package com.icia.yogiseo.dto;

import lombok.Data;

@Data
public class BookingDTO {
	private int bnum;
	private String storename;
	private String sid;
	private String mid;
	private String bname;
	private String bdate;
	private String btime;
	private int bpeople;
	private int bconfirm;
}
