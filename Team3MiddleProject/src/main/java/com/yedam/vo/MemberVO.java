package com.yedam.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int memberNo;
	private String memberName;
	private String memberId;
	private String memberPwd;
	private String memberPhone;
	private String memberEmail;
	private String memberBirth;
	private String memberAddress;
	private String memberGender;
	
//	private String responsibility;		// 일반사용자, 관리자 구분

	
}
