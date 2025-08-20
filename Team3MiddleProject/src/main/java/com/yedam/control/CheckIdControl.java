package com.yedam.control;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson; // Gson 라이브러리가 필요합니다.
import com.yedam.common.Control;
import com.yedam.service.MemberService;
import com.yedam.service.MemberServiceImpl;

public class CheckIdControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		// 1. 응답 타입을 JSON으로 설정합니다.
		resp.setContentType("application/json;charset=utf-8");

		// 2. 요청 파라미터에서 'id' 값을 가져옵니다.
		String id = req.getParameter("id");
		
		// 3. 서비스 계층을 통해 데이터베이스에서 ID 중복을 확인합니다.
		MemberService svc = new MemberServiceImpl();
		boolean isDuplicate = svc.checkId(id); // MemberService에 checkId 메서드를 구현해야 합니다.
		
		// 4. 결과를 담을 Map 객체를 생성합니다.
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("isDuplicate", isDuplicate);
		
		// 5. Map 객체를 JSON 문자열로 변환합니다.
		Gson gson = new Gson();
		String json = gson.toJson(resultMap);
		
		// 6. JSON 응답을 클라이언트(웹 브라우저)로 보냅니다.
		resp.getWriter().print(json);
	}

}