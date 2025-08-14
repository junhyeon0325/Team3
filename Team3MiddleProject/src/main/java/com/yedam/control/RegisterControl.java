package com.yedam.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;

public class RegisterControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) //
		throws ServletException, IOException {
			
	
		// WEB-INF/html/register_form.html
		// ↑여기를 들어갈 수 있게 만들기
		// page를 요청하면 html로 
	// 예외처리
			// 요청, 재지정 ↓ /  제일 상위 경로가 webapp이기에
			req.getRequestDispatcher("product/register_form.tiles")
					.forward(req, resp);
			//              ↑요청, 재지정해주는 객체
		
		// execute라는 메소드에서 예외가 발생하면, 책임을 frontControl로 책임을 떠 넘긴다
	}

}
