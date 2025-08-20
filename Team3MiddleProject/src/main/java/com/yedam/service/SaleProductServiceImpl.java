package com.yedam.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DBUtil;
import com.yedam.mapper.SaleProductMapper;
import com.yedam.vo.ProductVO;

public class SaleProductServiceImpl implements SaleProductService{
	SqlSession sqlsession = DBUtil.getInstance().openSession(true); // 자동 commit
	SaleProductMapper mapper = sqlsession.getMapper(SaleProductMapper.class);
	
	
	@Override
	public void discountUpdate() {
		mapper.discountUpdate();
		//sqlsession.commit();
	}
	
	
	@Override
	public List<ProductVO> getSaleProducts(int page, int pageSize, String sort, Integer maxPrice) {
		int startRow = (page-1) * pageSize;
		mapper.discountUpdate();   // 여기서도 호출
		return mapper.selectSaleProductList(startRow, pageSize, sort, maxPrice);
	}
	
	
	@Override
	public List<ProductVO> selectSaleProductList(int page, int pageSize, String sort, Integer maxPrice) {
		int startRow = (page-1) * pageSize;
		//int endRow = startRow + pageSize;
		return mapper.selectSaleProductList(startRow, pageSize, sort, maxPrice);
	}


	@Override
	public int countTotalSaleProducts() {
		return mapper.countTotalSaleProducts();
	}




}
