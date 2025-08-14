package com.yedam.common;

import lombok.Data;

@Data
public class PageDTO {
	private int currPage;    // 현재 페이지
	private int start, end;   // 시작, 끝 페이지
	private boolean previous, next;  // 이전, 다음 페이지
	
	public PageDTO(int page, int totalCnt)
	{
		currPage = page;
		end = (int) Math.ceil(page * 1.0 / 10) * 10;
		start = end -9;
		
		// 실제 마지막 페이지.
		int realEnd = (int) Math.ceil(totalCnt * 1.0 / 5);
		end = end > realEnd ? realEnd : end;
		
		// 이전 , 다음 페이지 여부.
		previous = start > 1; // ? true : false; 생략가능
		next = end < realEnd; 
	}
}
