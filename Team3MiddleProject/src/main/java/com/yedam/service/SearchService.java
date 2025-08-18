package com.yedam.service;

import java.util.List;

import com.yedam.vo.SearchVO;

public interface SearchService {
	//SearchVO productSales(int SearchVO);
	List<String> search(List<String> items, String keyword);
}
