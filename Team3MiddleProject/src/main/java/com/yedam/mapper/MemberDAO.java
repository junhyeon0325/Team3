package com.yedam.mapper;

import com.yedam.mapper.DAO;
import com.yedam.vo.MemberVO;

public class MemberDAO extends DAO {

    // 회원 정보 수정
    public boolean updateMember(MemberVO vo) {
        String sql = "UPDATE tbl_member "
                   + "SET member_pwd=?, member_name=?, member_phone=?, "
                   + "    member_gender=?, member_email=?, member_birth=?, member_address=? "
                   + "WHERE member_id=?";

        try {
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, vo.getMemberPwd());
            psmt.setString(2, vo.getMemberName());
            psmt.setString(3, vo.getMemberPhone());
            psmt.setString(4, vo.getMemberGender());
            psmt.setString(5, vo.getMemberEmail());
            psmt.setString(6, vo.getMemberBirth());
            psmt.setString(7, vo.getMemberAddress());
            psmt.setString(8, vo.getMemberId());

            int r = psmt.executeUpdate();
            return r > 0; // 성공 여부
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
