package com.yedam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.yedam.vo.SalesVO;

@Mapper
public interface SalesMapper {

	// 할인상품목록
	public List<SalesVO> SalesList(); 

}
