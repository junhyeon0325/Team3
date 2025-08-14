package com.yedam.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class SearchVO {
	private int id;
	private String productName;
	private String description;
	private int categoryId;
	private int productPrice;
	private Date createdAt;
}
