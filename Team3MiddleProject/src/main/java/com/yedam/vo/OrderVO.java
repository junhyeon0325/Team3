package com.yedam.vo;

import lombok.Data;

@Data
public class OrderVO {
	private int orderNo;
	private String orderAddress;
	private int usedPoint;
	private String orderDate;
	private int orderPrice;
	private String orderRequest;
	private int memberNo;
	private int productNo;
	
}
