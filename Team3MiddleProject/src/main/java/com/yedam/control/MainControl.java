package com.yedam.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;

public class MainControl implements Control{
	
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp)// 
			throws ServletException, IOException {
		//req.getRequestDispatcher("index.jsp").forward(req, resp);
		req.getRequestDispatcher("product/productMain.tiles").forward(req, resp);
	}
}