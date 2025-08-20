package com.yedam.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.control.CartListControl;
import com.yedam.control.DetailSelectcontrol;
import com.yedam.control.FrozenProductListControl;
import com.yedam.control.MainControl;
import com.yedam.control.ProductListControl;
import com.yedam.control.ProductSelectControl;
import com.yedam.control.SalesControl;
import com.yedam.control.SearchControl;
import com.yedam.control.ModifyCartProductPcsControl;
import com.yedam.control.OrderFormControl;
import com.yedam.control.OrderTempSaveControl;
import com.yedam.control.PaymentConfirmControl;
import com.yedam.control.PaymentDetailControl;
import com.yedam.control.PaymentFailControl;
import com.yedam.control.PaymentSuccessControl;
import com.yedam.control.ProductListControl;
import com.yedam.control.ProductSelectControl;
import com.yedam.control.RemoveCartListSingleControl;
import com.yedam.control.ReviewControl;

public class FrontController extends HttpServlet{
	Map<String, Control> map;
	
	// 생성자
	public FrontController() {
		map = new HashMap<String, Control>();
	}
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		map.put("/main.do", new MainControl());

		map.put("/productList.do", new ProductListControl());
		map.put("/detailPage.do", new DetailSelectcontrol());
		map.put("/review.do", new ReviewControl());
		
		map.put("/productSelect.do", new ProductSelectControl());
		map.put("/sales.do", new SalesControl());
		map.put("/search.do", new SearchControl());
		
		// 장바구니
		map.put("/cartlistform.do", new CartListControl());	// 장바구니 목록 출력
		map.put("/modifyCartProductPcs.do", new ModifyCartProductPcsControl());	// 장바구니 수량 수정 
		map.put("/removeCartListSingle.do", new RemoveCartListSingleControl());	// 장바구니 목록 한줄 삭제
		
		// 주문/결제
		map.put("/orderform.do", new OrderFormControl());	// 주문/결제 화면 출력
		map.put("/paymentSuccess.do", new PaymentSuccessControl());
	    map.put("/paymentFail.do", new PaymentFailControl());
	    map.put("/paymentConfirm.do", new PaymentConfirmControl());
	    map.put("/paymentDetail.do", new PaymentDetailControl());
        map.put("/saveTemporaryOrderData.do", new OrderTempSaveControl()); // 주문정보임시저장

	    
		
		map.put("/frozenProductList.do", new FrozenProductListControl());
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String context = req.getContextPath();
		String path = uri.substring(context.length());

		Control sub = map.get(path);
		sub.execute(req, resp);
	}
}
