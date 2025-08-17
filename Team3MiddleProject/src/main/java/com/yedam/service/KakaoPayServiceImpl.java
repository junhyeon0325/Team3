package com.yedam.service;

import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;

import com.swimlover.kakaopay.ReadyResponse;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class KakaoPayServiceImpl {
	
	/*
	 * 카카오톡 Pay API에 요청하기 위한 작업
	 * 1) HttpURLConnection을 이용한 HTTP 통신
	 * 2) Rest Template를 이용한 통신(권장) : https://minkwon4.tistory.com/178
	 */
	
	/*
	 * 첫번째 요청주소
	 * POST /v1/payment/ready HTTP/1.1
	 * HOST: kapi.kakao.com
	 * Authorization: KakaoAK ${APP_ADMIN_KEY}
	 * Content-type: application/x-www-form-urlencoded;charset=utf-8
	 */
	
	public ReadyResponse payReady(String itenName, int quantity, String mem_id, int totalAmount) {
		
		String order_id = "100";
		
		// 카카오페이에 요청할 request 정보 구성작업
		// 컬렉션 클래스를 이용하여, 구성한다.
		// Map 컬렉션 : 하나의 키에 값만 저장하는 특징.
		// Map<String, String> map = new LinkedHashMap<String, String> ();
		
		// 하나의 키에 여러개의 값을 저장하는 특징. 스프링에서 제공.
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("cid", "TC0ONETIME");
		return null;
		
		
	}
}
