package com.yedam.service;

import java.util.List;

import com.yedam.vo.ProductVO;

public interface ProductListService {
	List<ProductVO> getProductList(int page, int pageSize, String sort, String maincategory);
    int getTotalProductCount(String maincategory);
}