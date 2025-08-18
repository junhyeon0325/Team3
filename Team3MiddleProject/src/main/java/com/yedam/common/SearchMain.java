package com.yedam.common;

import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

import com.yedam.service.SearchService;
import com.yedam.service.SearchServiceImpl;

public class SearchMain {
	public static void main(String[] args) {
        List<String> items = Arrays.asList("꽃갈비살", "살치살", "등심", "안심","와규","닭","달걀","양념소불고기","간장돼지불고기","오리석쇠불고기",
        		"연어필렛","키조개","오징어","방어","낙지","고등어","갈치","가자미","감자","고구마","깐마늘","깻잎","당근","대파","마늘","브로콜리","양배추",
				"양파","오이","파프리카","표고버섯");

        Scanner scanner = new Scanner(System.in);
        System.out.print("검색어를 입력하세요: ");
        String keyword = scanner.nextLine();

        SearchService searchService = (SearchService) new SearchServiceImpl();
        List<String> results = searchService.search(items, keyword);

        if (results.isEmpty()) {
            System.out.println("결과가 없습니다.");
        } else {
            System.out.println("검색 결과:");
            for (String item : results) {
                System.out.println("- " + item);
            }
        }

        scanner.close();
	} 
}
