package com.yedam.vo;

import lombok.Data;
import java.util.List;

@Data
public class OrderTempVO {
    private String orderAddress;
    private String orderRequest;
    private int usedPoint;
    private int memberNo;
    private List<CartProductVO> cartList; // 장바구니/주문 상품 목록
}
