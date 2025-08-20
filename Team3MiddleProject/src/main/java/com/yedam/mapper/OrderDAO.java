package com.yedam.mapper; // 또는 com.yedam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.yedam.common.DataSource; // JDBC 연결을 위한 DataSource 클래스 필요
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
        String sql = "INSERT INTO tbl_order (order_no, order_address, used_point, order_price, order_request, member_no) VALUES (?, ?, ?, ?, ?, ?)";
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
        int totalInsertedCount = 0; // 실제로 배치에 추가된 항목 수

        try {
            conn = DataSource.getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작

            // PreparedStatement를 반복문 바깥에서 한 번만 생성합니다. (매우 중요!)
            psmt = conn.prepareStatement(sql); 

            for (CartProductVO item : cartItems) {
                // 수량(productPcs)이 0보다 큰 상품만 배치에 추가합니다.
                if (item.getProductPcs() > 0) {
                    psmt.setInt(1, item.getProductPcs());
                    psmt.setInt(2, item.getProductNo());
                    psmt.setLong(3, orderNo);
                    psmt.addBatch(); // 배치에 추가
                    totalInsertedCount++; // 배치에 추가된 항목 수 증가
                } else {
                    System.out.println("DEBUG: 수량이 0인 장바구니 항목을 건너뜁니다. (상품 번호: " + item.getProductNo() + ")");
                }
            }

            if (totalInsertedCount > 0) { // 배치에 추가된 항목이 있을 때만 실행
                int[] results = psmt.executeBatch(); // 배치 실행
                // executeBatch()의 결과는 각 항목의 성공/실패를 나타내는 배열입니다.
                // 성공적으로 삽입된 항목의 수를 더 정확하게 세려면 이 배열을 순회해야 하지만,
                // 여기서는 간단히 배치에 추가된 총 항목 수를 반환합니다.
            } else {
                System.out.println("DEBUG: tbl_order_items에 삽입할 유효한 상품이 없습니다.");
            }
            
            conn.commit(); // 트랜잭션 커밋
            // 반환 값은 실제로 배치에 추가된 항목의 수 (성공 여부와 무관하게 시도된 수)
            // executeBatch()의 결과를 직접 세는 것이 더 정확합니다.
            // 여기서는 totalInsertedCount를 반환하여 시도된 수를 나타냅니다.
            return totalInsertedCount;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                conn.rollback(); // 오류 발생 시 롤백
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            return 0; // 실패 시 0 반환
        } finally {
            // finally 블록에서 psmt와 conn을 닫습니다. (close() 메서드에서 처리)
            close(); 
        }
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
