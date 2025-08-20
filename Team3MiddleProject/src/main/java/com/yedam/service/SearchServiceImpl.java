package com.yedam.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DBUtil;
import com.yedam.mapper.SearchMapper;
import com.yedam.vo.SearchVO;

public class SearchServiceImpl implements SearchService{
	SqlSession sqlsession = DBUtil.getInstance().openSession();
	SearchMapper mapper = sqlsession.getMapper(SearchMapper.class);
	
	@Override
	public List<SearchVO> searchList(String pd) {
		
		return mapper.searchProducts(pd);
	}

}