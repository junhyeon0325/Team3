package com.yedam.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DBUtil;
import com.yedam.mapper.SalesMapper;
import com.yedam.vo.ProductVO;
import com.yedam.vo.SalesVO;

public class SalesServiceImpl implements ProductListService{
	SqlSession sqlsession = DBUtil.getInstance().openSession();
	SalesMapper mapper = sqlsession.getMapper(SalesMapper.class);
	
	@Override
	public List<ProductVO> getProductList() {
		
		return null;
	}
}
