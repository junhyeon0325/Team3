package com.yedam.service;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DBUtil;
import com.yedam.mapper.MemberMapper;
import com.yedam.vo.MemberVO;

public class MemberServiceImpl implements MemberService {

	SqlSession sqlSession = DBUtil.getInstance().openSession();
	MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);

	@Override
	public boolean insertMember(MemberVO member) {
		int r = mapper.insertMember(member);
		if (r > 0) {
			sqlSession.commit();
			return true; // 정상등록
		}
		return false;
	}

	@Override
	public MemberVO userCheck(String id, String pwd) {
		return mapper.selectMember(id, pwd);
	}

	@Override
	public boolean checkId(String id) {
		int count = mapper.checkId(id);
		// count가 1 이상이면 중복이라는 뜻이므로 true를 반환
		return count > 0;
	}

	@Override
	public boolean updateMember(MemberVO vo) {
		return mapper.updateMember(vo) == 1;
}
}