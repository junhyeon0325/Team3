package com.yedam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yedam.vo.ProductVO;

public interface ProductListMapper {
	public List<ProductVO> selectProductList(@Param("startRow")int startRow, @Param("pageSize")int pageSize, @Param("sort")String sort);
	int countTotalProducts();
	
}