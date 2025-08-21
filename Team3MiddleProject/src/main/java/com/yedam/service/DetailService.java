package com.yedam.service;

import java.util.List;
import java.util.Map;

import com.yedam.vo.ProductVO;

public interface DetailService {
	ProductVO productDetail(int productNo);
	List<ProductVO> relatedProducts(Map<String, Object>param);
}
//실행