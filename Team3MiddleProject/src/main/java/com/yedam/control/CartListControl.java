package com.yedam.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.yedam.common.Control;
import com.yedam.service.CartService;
import com.yedam.service.CartServiceImpl;
import com.yedam.vo.ProductVO;

public class CartListControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 저장된 id세션을 가져오기
		//HttpSession session = req.getSession();	 
		String memberId = "jjh";//(String) session.getAttribute("logId");
		
		CartService svc = new CartServiceImpl();
		List<ProductVO> list = svc.cartList(memberId);
		System.out.println(list);
		
		Gson gson = new GsonBuilder().create();
		String json = gson.toJson(list);
		
		resp.getWriter().print(json);
		
	}

}
