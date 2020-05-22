package relay.common;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import relay.vo.product.ShoppingCondition;


public class APISearch {

	// API Connection 객체를 전역변수로 전언
	private static HttpURLConnection conn;

	// API Connection 객체의 attribute 변수 설정(naver developer 에서 받은 ID, PW 그리고 GET방식으로
	// request요청)
	private final static HttpURLConnection connection(URL url) {
		try {
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("X-Naver-Client-Id", "tiKUZvCpQGEPI0wc7iX8");
			conn.setRequestProperty("X-Naver-Client-Secret", "BXS_2Ams3x");
		} catch (IOException e) {
			System.err.println("API Request Failed");
		}
		return conn;
	}

	// Controller에서 검색어, 출력될 상품 개수, 시작지점, sorting방식을 ShoppingCondition 객체에 담아 전달
	// 전달 받은 값을 API 요청주소의 query parameter에 대입시키고 connection 연결
	// response 결과를 parsing()로 처리하여 return
	public static ArrayList<JSONObject> searchList(ShoppingCondition sc) {

		ArrayList<JSONObject> array = new ArrayList<JSONObject>();
		try {
			String text = URLEncoder.encode(sc.getWord(), "UTF-8");
			int display = sc.getDisplay();
			int start = sc.getStart();
			String sort = sc.getSort();
			// API 요청 주소
			String apiURL = "https://openapi.naver.com/v1/search/shop.json?query=" + text + "&display=" + display
					+ "&start=" + start + "&sort=" + sort;
			URL url = new URL(apiURL);
			// 윗 주소로 connection 연결
			conn = connection(url);
			int responseCode = conn.getResponseCode();
			// responsecode가 200일 때, 즉 오류없이 요청 성공일 때 InputStream을 열어 결과를 가저옴
			// 그리고 아래 parsing()(#76 line)으로 결과 중 네이버 상품정보 format에 맞는 상품들만 가져옴
			if (responseCode == 200) {
				array = parsing(array, new InputStreamReader(conn.getInputStream(), "UTF-8"));
			} else {
				System.out.println("responsecode : "+responseCode);
			}
		} catch (UnsupportedEncodingException e) {
			System.err.println("UnsupportedEncodingException of searching text");
		} catch (MalformedURLException e) {
			System.err.println("Invalid URL");
		} catch (IOException e) {
			System.err.println("Invalid response");
		}
		conn.disconnect();
		return array;
	}

	// response 결과 중 필요한 내용만 가져옴
	private static ArrayList<JSONObject> parsing(ArrayList<JSONObject> array, InputStreamReader isr) {
		
		try {
			JSONParser par = new JSONParser();
			JSONObject ob = (JSONObject) par.parse(isr);
			// response 결과는 json 형태로 상품들의 정보는 key가 'item'인 value에 있다.
			// 따라서 JSONParser로 items 부분만 추출하고 그중 'mallName'이 '네이버'인 상품만 가져온다.(format 때문에) 
			ArrayList<JSONObject> parsed = (ArrayList<JSONObject>) ob.get("items");
			parsed.removeIf(i -> !i.containsValue("네이버"));
			array.addAll(parsed);
		} catch (IOException e) {
			e.printStackTrace();
		} catch(ParseException e) {
			e.printStackTrace();
		}
		return array;
	}

}
