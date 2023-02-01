package com.care.root;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import java.io.BufferedReader;
import java.io.IOException;

@Controller
public class libraryApiController {
	@GetMapping("index")
	public void api(HttpServletRequest request, Model model) throws IOException {
		try{ 
			StringBuilder urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088/6f6344515963687a35336577734644/json/SeoulPublicLibraryInfo/1/5/"); /*URL*/
			urlBuilder.append("/" +  URLEncoder.encode("6f6344515963687a35336577734644","UTF-8") ); /*인증키 (sample사용시에는 호출시 제한됩니다.)*/
			urlBuilder.append("/" +  URLEncoder.encode("json","UTF-8") ); /*요청파일타입 (xml,xmlf,xls,json) */
			urlBuilder.append("/" + URLEncoder.encode("CardSubwayStatsNew","UTF-8")); /*서비스명 (대소문자 구분 필수입니다.)*/
			urlBuilder.append("/" + URLEncoder.encode("1","UTF-8")); /*요청시작위치 (sample인증키 사용시 5이내 숫자)*/
			urlBuilder.append("/" + URLEncoder.encode("5","UTF-8")); /*요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨)*/
			urlBuilder.append("/" + URLEncoder.encode("LBRRY_SEQ_NO","UTF-8")); /*요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨)*/
			urlBuilder.append("/" + URLEncoder.encode("LBRRY_NAME","UTF-8")); /*요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨)*/
			urlBuilder.append("/" + URLEncoder.encode("CODE_VALUE","UTF-8")); /*요청종료위치(sample인증키 사용시 5이상 숫자 선택 안 됨)*/
			// 상위 5개는 필수적으로 순서바꾸지 않고 호출해야 합니다.

			// 서비스별 추가 요청 인자이며 자세한 내용은 각 서비스별 '요청인자'부분에 자세히 나와 있습니다.
//			urlBuilder.append("/" + URLEncoder.encode("20220301","UTF-8")); /* 서비스별 추가 요청인자들*/

			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			System.out.println("Response code: " + conn.getResponseCode()); /* 연결 자체에 대한 확인이 필요하므로 추가합니다.*/
			BufferedReader rd;

			// 서비스코드가 정상이면 200~300사이의 숫자가 나옵니다.
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				System.out.println("연결성공");
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			System.out.println(sb.toString());
			 // 1. 문자열 형태의 JSON을 파싱하기 위한 JSONParser 객체 생성.
	        JSONParser parser = new JSONParser();
	        // 2. 문자열을 JSON 형태로 JSONObject 객체에 저장. 	
	        JSONObject obj = (JSONObject)parser.parse(sb.toString());
	        // 3. 필요한 리스트 데이터 부분만 가져와 JSONArray로 저장.
	        JSONArray dataArr = (JSONArray) obj.get("data");
	        // 4. model에 담아준다.
	        model.addAttribute("data",dataArr);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
	}
}