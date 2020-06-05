package com.icia.yogiseo.dto;

import lombok.Data;

@Data
public class MessageDTO {
	private int mnum;
	private String msender;
	private String mreceiver;
	private String mcontents;
	private int malert;
	private String mdate;
	
}
