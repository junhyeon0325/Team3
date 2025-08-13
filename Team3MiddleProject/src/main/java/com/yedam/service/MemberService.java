package com.yedam.service;

import com.yedam.vo.MemberVO;

// 회원관련업무

public interface MemberService {
	public boolean addMember(MemberVO member);
	public MemberVO userCheck(String id, String pw);
}
