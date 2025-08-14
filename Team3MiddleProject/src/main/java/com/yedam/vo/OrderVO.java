package com.yedam.vo;

import lombok.Data;

@Data
public class OrderVO {
	private int orderNo;
	private String orderAddress;
	private int usedPoint;
	private String orderDate;
	private String maincategory;
	private String subcategory;
	private double productScore;
	private String productImage;
	private String productAbout;
	private String expirationDate;
	private String productDesc;
}
