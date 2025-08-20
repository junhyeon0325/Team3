package com.yedam.service;

import java.util.List;

import com.yedam.vo.SearchVO;

public interface SearchService {

	List<SearchVO> searchList(String pd);
	//SearchVO productSales(int SearchVO);
	
}
