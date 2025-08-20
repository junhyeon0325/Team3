package com.yedam.service;

import java.util.List;

import com.yedam.vo.ProductVO;

public interface SaleProductService {
	void discountUpdate();   // 따로 호출할 수 있음
    List<ProductVO> getSaleProducts(int page, int pageSize, String sort, Integer maxPrice);
	List<ProductVO> selectSaleProductList(int page, int pageSize, String sort, Integer maxPrice);
	int countTotalSaleProducts();
}
