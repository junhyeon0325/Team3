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
	public List<ProductVO> getProductList(int page, int pageSize, String sort, String maincategory) {
		int startRow = (page - 1) * pageSize;
        return mapper.selectProductList(startRow,pageSize, sort, maincategory);
	}
	
	@Override
	public int getTotalProductCount(String maincategory)
	{
		return mapper.countTotalProducts(maincategory);
	}

}