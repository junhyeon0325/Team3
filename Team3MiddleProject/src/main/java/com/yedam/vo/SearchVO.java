package com.yedam.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class SearchVO {
	
	private int productNo;
	private String productName;
	private String productSeller;
	private int productPrice;
	private String maincategory;
	private String subcategory;
	private int productScore;
	private String productImage;
	private String productAbout;
	private int expiration_date;
}
