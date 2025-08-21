package com.yedam.mapper;

import java.util.List;
import java.util.Map;

import com.yedam.vo.ProductVO;

public interface DetailMapper {
	ProductVO selectDetail(int porductNo); // 상품 상세
	List<ProductVO> relatedSelect(Map<String, Object> param); // 관련 상품
}
//db랑 연결