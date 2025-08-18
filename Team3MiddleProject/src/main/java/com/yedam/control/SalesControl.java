package com.yedam.control;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;

import com.yedam.common.Control;
import com.yedam.service.SalesService;
import com.yedam.service.SalesServiceImpl;
import com.yedam.vo.SalesVO;

import ch.qos.logback.core.model.Model;

public class SalesControl implements Control {

	
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		SalesService prd = (SalesService) new SalesServiceImpl();
		List<SalesVO> SalesList = prd.getSalesList();
		
		req.setAttribute("SalesList", SalesList);
		
		req.getRequestDispatcher("Sales/SalesList.tiles").forward(req, resp);

		
		
	}

}
