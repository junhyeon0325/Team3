package com.yedam.service;

import java.util.List;

import com.yedam.vo.ProductVO;

public interface SaleProductService {
	List<ProductVO> selectSaleProductList(int page, int pageSize);
	int countTotalSaleProducts();
}
