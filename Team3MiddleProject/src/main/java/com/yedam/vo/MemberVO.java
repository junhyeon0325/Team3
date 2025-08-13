package com.yedam.vo;

import lombok.Data;

@Data
public class MemberVO {
	private String memberId;
	private String memberPw;
	private String memberName;
	private String responsibility;		// 일반사용자, 관리자 구분

	
}
