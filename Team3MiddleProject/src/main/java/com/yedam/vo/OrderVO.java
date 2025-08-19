package com.yedam.vo;

import lombok.Data; // Lombok 사용 시

@Data // Lombok 어노테이션
public class OrderVO {
    private long orderNo; // 주문 번호 (PK)
    private String orderAddress; // 주문 주소
    private int usedPoint; // 사용 포인트
    private int orderPrice; // 주문 금액
    private String orderRequest; // 주문 요청사항
    private int memberNo; // 회원 번호 (FK)
    private int productNo; // tbl_order에서는 삭제. tbl_order_items에만 존재
    // private String orderDate; // sysdate로 자동 입력되므로 VO에 포함하지 않아도 됨

    // Lombok 사용하지 않을 시, getter/setter, 생성자 등을 직접 구현
}