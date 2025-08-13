package com.yedam.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DBUtil;
import com.yedam.mapper.ProductListMapper;
import com.yedam.vo.ProductVO;

public class ProductListServiceImpl implements ProductListService{
	SqlSession sqlsession = DBUtil.getInstance().openSession();
	ProductListMapper mapper = sqlsession.getMapper(ProductListMapper.class);
	
	
	@Override
	public List<ProductVO> getProductList() {
		List<ProductVO> list = mapper.selectProductList();
		return list;
	}

}
