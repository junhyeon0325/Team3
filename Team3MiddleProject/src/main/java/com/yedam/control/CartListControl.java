package com.yedam.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.CartService;
import com.yedam.service.CartServiceImpl;
import com.yedam.vo.CartProductVO;


public class CartListControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//resp.setContentType("text/json;charset=utf-8");
		
		// 저장된 id세션을 가져오기
		//HttpSession session = req.getSession();	
		String memberId = "jjh";//(String) session.getAttribute("logId");

		// 서비스 호출
		CartService svc = new CartServiceImpl();
		List<CartProductVO> list = svc.CartProductList(memberId);	// 현재 로그인한 ID의 장바구니 상품상세 출력 
		System.out.println(list);
		
		
		
		
		//Gson gson = new GsonBuilder().create();
		//String json = gson.toJson(list);
		//resp.getWriter().print(json);
		
		req.setAttribute("cp_list", list);
		req.getRequestDispatcher("product/cart.tiles").forward(req, resp);
		
	}

}
