package com.yedam.service;

import java.util.ArrayList;
import java.util.List;

public class SearchServiceImpl {
	 public List<String> search(List<String> items, String keyword) {
	        List<String> results = new ArrayList<>();
	        for (String item : items) {
	        if (item.contains(keyword)) {
	            results.add(item);
	          
	        }
	    }
	        return results;
	 }
}
