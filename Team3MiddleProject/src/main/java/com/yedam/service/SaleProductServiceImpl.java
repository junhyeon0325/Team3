package com.yedam.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DBUtil;
import com.yedam.mapper.SaleProductMapper;
import com.yedam.vo.ProductVO;

public class SaleProductServiceImpl implements SaleProductService{
	SqlSession sqlsession = DBUtil.getInstance().openSession();
	SaleProductMapper mapper = sqlsession.getMapper(SaleProductMapper.class);
	
	
	@Override
	public List<ProductVO> selectSaleProductList(int page, int pageSize) {
		int startRow = (page-1) * pageSize;
		//int endRow = startRow + pageSize;
		return mapper.selectSaleProductList(startRow, pageSize);
	}


	@Override
	public int countTotalSaleProducts() {
		return mapper.countTotalSaleProducts();
	}
}
