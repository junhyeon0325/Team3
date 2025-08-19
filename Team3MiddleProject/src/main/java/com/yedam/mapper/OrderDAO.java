package com.yedam.mapper; // 또는 com.yedam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List; // CartProductVO와 같은 VO 리스트를 위한 import

import com.yedam.common.DataSource;
// 필요한 VO 클래스들 (OrderVO, CartProductVO)
import com.yedam.vo.CartProductVO; // order.jsp에서 사용하므로 이미 있을 것입니다.
import com.yedam.vo.OrderVO; // 주문 정보 저장을 위한 VO (아래에서 정의)

public class OrderDAO {

    // JDBC 관련 필드
    private Connection conn;
    private PreparedStatement psmt;
    private ResultSet rs;

    // 자원 반납
    private void close() {
        try {
            if (rs != null) rs.close();
            if (psmt != null) psmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 주문 정보 (tbl_order) 삽입 메서드
    public int insertOrder(OrderVO order) {
        String sql = "INSERT INTO tbl_order (order_no, order_address, used_point, order_price, order_request, member_no, product_no) VALUES (?, ?, ?, ?, ?, ?, ?)";
        int r = 0;
        try {
            conn = DataSource.getConnection();
            psmt = conn.prepareStatement(sql);
            psmt.setLong(1, order.getOrderNo()); // order_no는 Toss orderId를 사용하거나, DB 시퀀스를 통해 생성
            psmt.setString(2, order.getOrderAddress());
            psmt.setInt(3, order.getUsedPoint());
            psmt.setInt(4, order.getOrderPrice());
            psmt.setString(5, order.getOrderRequest());
            psmt.setInt(6, order.getMemberNo());
            psmt.setInt(7, order.getProductNo()); // <<--- 이 줄을 다시 추가합니다.

            
            r = psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return r;
    }

    // 주문 상세 항목 (tbl_order_items) 삽입 메서드
    // orderNo: 방금 삽입된 tbl_order의 order_no
    // cartItems: 사용자의 장바구니/주문 상품 목록 (CartProductVO 리스트)
    public int insertOrderItems(long orderNo, List<CartProductVO> cartItems) {
    	// order_item_no는 시퀀스에서 자동 생성되므로 SQL에서 해당 부분을 제거합니다.
        // ORA-00904 오류는 SQL 구문이나 바인딩 문제인데, 시퀀스 사용으로 변경하여 더 깔끔하게 처리합니다.
        String sql = "INSERT INTO tbl_order_items (product_pcs, product_no, order_no) VALUES (?, ?, ?)";
        int r = 0;
        try {
            conn = DataSource.getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작

            for (CartProductVO item : cartItems) {
                psmt = conn.prepareStatement(sql);
                psmt.setInt(1, item.getProductPcs());
                psmt.setInt(2, item.getProductNo());
                psmt.setLong(3, orderNo); // tbl_order의 order_no를 FK로 사용
                psmt.addBatch(); // 배치 작업 추가
            }
            int[] results = psmt.executeBatch(); // 배치 실행
            conn.commit(); // 커밋
            r = results.length; // 삽입된 레코드 수
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                conn.rollback(); // 롤백
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        } finally {
            close();
        }
        return r;
    }

    // 다음 주문 번호를 가져오는 메서드 (시퀀스를 사용하거나 Toss orderId를 활용)
    public long getNextOrderNo() {
        String sql = "SELECT NVL(MAX(order_no), 0) + 1 FROM tbl_order"; // 간단한 자동 증가 (실제 운영에서는 시퀀스 사용)
        long nextOrderNo = 0;
        try {
            conn = DataSource.getConnection();
            psmt = conn.prepareStatement(sql);
            rs = psmt.executeQuery();
            if (rs.next()) {
                nextOrderNo = rs.getLong(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return nextOrderNo;
    }
}