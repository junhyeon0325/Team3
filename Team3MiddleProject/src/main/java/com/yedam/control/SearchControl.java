package com.yedam.control;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestParam;

import com.yedam.common.Control;

public class SearchControl implements Control {

		  
	public String search(@RequestParam("keyword") String keyword, ModelMap model) {
		List<String> allItems = List.of
				("꽃갈비살", "살치살", "등심", "안심","와규","닭","달걀","양념소불고기","연어필렛","키조개",
				"오징어","방어","낙지","고등어","갈치","가자미","감자","고구마","깐마늘","깻잎","당근","대파","마늘","브로콜리","양배추",
				"양파","오이","파프리카","표고버섯","간장돼지불고기","오리석쇠불고기");
		List<String> results = allItems.stream()
		   .filter(item -> item.contains(keyword))
		   .collect(Collectors.toList());

		        model.addAttribute("results", results);
		        return "searchResult"; // JSP or Thymeleaf 페이지	
		
	}

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
