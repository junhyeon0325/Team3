package com.yedam.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ProductVO {
	private int productNo;
	private String productName;
	private String productSeller;
	private int productPrice;
	private String subcategory;
	private int productScore;
	private String productImage;
	private String productAbout;
	private Date expirationDate;
	
}
