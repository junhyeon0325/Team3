package com.yedam.vo;

import lombok.Data;

@Data
public class ProductVO {
	private int productNo;
	private String productName;
	private String productSeller;
	private int productPrice;
	private String subCategory;
	private int productScore;
	private String productImage;
	private String productAbout;
	private String expirationDate;
}
