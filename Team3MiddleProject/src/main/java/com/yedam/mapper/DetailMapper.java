package com.yedam.mapper;

import com.yedam.vo.ProductVO;

public interface DetailMapper {
	ProductVO selectDetail(int porductNo); // 상품 상세
}