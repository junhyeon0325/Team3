package com.yedam.vo;

import lombok.Data;

@Data
public class ProductVO {
	private int productNo;
	private String productName;
	private String productSeller;
	private int productPrice;
	private String maincategory;
	private String subcategory;
	private int productScore;
	private String productImage;
	private String productAbout;
	private String expirationDate;
	private String productDesc;
}
