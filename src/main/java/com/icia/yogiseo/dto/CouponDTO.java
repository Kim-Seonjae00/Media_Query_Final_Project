package com.icia.yogiseo.dto;

import lombok.Data;

@Data
public class CouponDTO {
	private int couponnum;
	private String mid;
	private String couponname;
	private int discount;
	private String issuedate;
	private String enddate;
}
