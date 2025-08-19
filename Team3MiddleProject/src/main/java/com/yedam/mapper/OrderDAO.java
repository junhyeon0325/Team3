package com.yedam.mapper; // 또는 com.yedam.dao;

import com.yedam.common.DataSource; // JDBC 연결을 위한 DataSource 클래스 필요
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

// 필요한 VO 클래스들
import com.yedam.vo.CartProductVO; 
import com.yedam.vo.OrderVO; 

public class OrderDAO {

    private Connection conn;
    private PreparedStatement psmt;
    private ResultSet rs;

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
        // =========================================================
        // 시작: SQL 쿼리에서 product_no 컬럼 제거
        // =========================================================
        // SQL 쿼리에서 'product_no'를 완전히 제거합니다.
        String sql = "INSERT INTO tbl_order (order_no, order_address, used_point, order_price, order_request, member_no) VALUES (?, ?, ?, ?, ?, ?)";
        // =========================================================
        // 끝: SQL 쿼리에서 product_no 컬럼 제거
        // =========================================================
        int r = 0;
        try {
            conn = DataSource.getConnection();
            psmt = conn.prepareStatement(sql);
            psmt.setLong(1, order.getOrderNo());
            psmt.setString(2, order.getOrderAddress());
            psmt.setInt(3, order.getUsedPoint());
            psmt.setInt(4, order.getOrderPrice());
            psmt.setString(5, order.getOrderRequest());
            psmt.setInt(6, order.getMemberNo());
            // psmt.setInt(7, order.getProductNo()); // <<--- 이 줄을 삭제합니다!
            
            r = psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return r;
    }

    // 주문 상세 항목 (tbl_order_items) 삽입 메서드 (이전 수정 그대로 유지)
    public int insertOrderItems(long orderNo, List<CartProductVO> cartItems) {
        String sql = "INSERT INTO tbl_order_items (product_pcs, product_no, order_no) VALUES (?, ?, ?)";
        int r = 0;
        try {
            conn = DataSource.getConnection();
            conn.setAutoCommit(false); 

            for (CartProductVO item : cartItems) {
                psmt = conn.prepareStatement(sql);
                psmt.setInt(1, item.getProductPcs());
                psmt.setInt(2, item.getProductNo());
                psmt.setLong(3, orderNo); 
                psmt.addBatch(); 
            }
            int[] results = psmt.executeBatch(); 
            conn.commit(); 
            r = results.length;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                conn.rollback(); 
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        } finally {
            close();
        }
        return r;
    }

    // 다음 주문 번호를 가져오는 메서드 (이전 수정 그대로 유지)
    public long getNextOrderNo() {
        String sql = "SELECT NVL(MAX(order_no), 0) + 1 FROM tbl_order";
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
