package com.yedam.mapper;

import java.util.List;

import com.yedam.vo.SearchVO;

public interface SearchMapper {
	
		public List<SearchVO> productList();
		
		public SearchVO selectProduct(); 
}
