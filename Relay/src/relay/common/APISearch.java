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

	// API Connection ��ü�� ���������� ����
	private static HttpURLConnection conn;

	// API Connection ��ü�� attribute ���� ����(naver developer ���� ���� ID, PW �׸��� GET�������
	// request��û)
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

	// Controller���� �˻���, ��µ� ��ǰ ����, ��������, sorting����� ShoppingCondition ��ü�� ��� ����
	// ���� ���� ���� API ��û�ּ��� query parameter�� ���Խ�Ű�� connection ����
	// response ����� parsing()�� ó���Ͽ� return
	public static ArrayList<JSONObject> searchList(ShoppingCondition sc) {

		ArrayList<JSONObject> array = new ArrayList<JSONObject>();
		try {
			String text = URLEncoder.encode(sc.getWord(), "UTF-8");
			int display = sc.getDisplay();
			int start = sc.getStart();
			String sort = sc.getSort();
			// API ��û �ּ�
			String apiURL = "https://openapi.naver.com/v1/search/shop.json?query=" + text + "&display=" + display
					+ "&start=" + start + "&sort=" + sort;
			URL url = new URL(apiURL);
			// �� �ּҷ� connection ����
			conn = connection(url);
			int responseCode = conn.getResponseCode();
			// responsecode�� 200�� ��, �� �������� ��û ������ �� InputStream�� ���� ����� ������
			// �׸��� �Ʒ� parsing()(#76 line)���� ��� �� ���̹� ��ǰ���� format�� �´� ��ǰ�鸸 ������
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

	// response ��� �� �ʿ��� ���븸 ������
	private static ArrayList<JSONObject> parsing(ArrayList<JSONObject> array, InputStreamReader isr) {
		
		try {
			JSONParser par = new JSONParser();
			JSONObject ob = (JSONObject) par.parse(isr);
			// response ����� json ���·� ��ǰ���� ������ key�� 'item'�� value�� �ִ�.
			// ���� JSONParser�� items �κи� �����ϰ� ���� 'mallName'�� '���̹�'�� ��ǰ�� �����´�.(format ������) 
			ArrayList<JSONObject> parsed = (ArrayList<JSONObject>) ob.get("items");
			parsed.removeIf(i -> !i.containsValue("���̹�"));
			array.addAll(parsed);
		} catch (IOException e) {
			e.printStackTrace();
		} catch(ParseException e) {
			e.printStackTrace();
		}
		return array;
	}

}
