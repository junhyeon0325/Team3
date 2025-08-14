package com.yedam.common;

import lombok.Data;

@Data
public class SearchDTO {
	private int page;
	private String searchCondition;
	private String keyword;
}
