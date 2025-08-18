package com.yedam.vo;

import lombok.Data;

@Data
public class ReviewVO {
	private int reviewNo;
	private int reviewScore;
	private String reviewContent;
	private String reviewImage;
	private String reviewDate;
	private int productNo;
	private int orderNo;
	private String memberName;
	private String memberId;
}
