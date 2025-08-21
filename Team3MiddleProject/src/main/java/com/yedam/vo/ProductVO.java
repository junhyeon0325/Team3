package com.yedam.vo;

import lombok.Data;

@Data
public class ProductVO {
	private int productNo;
	private String productName;
	private String productSeller;
	private int productPrice;
	private String maincategory;
	private double productScore;
	private String productImage;
	private String productAbout;
	private String expirationDate;
	private int discountRate;     // 할인율 (%)
	private int discountPrice;    // 할인된 금액
}
