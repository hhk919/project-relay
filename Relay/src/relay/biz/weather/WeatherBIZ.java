package relay.biz.weather;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import relay.vo.weather.WeatherVO;

@Service
public class WeatherBIZ {
	
	public WeatherVO getWeather() {
		String urlstr = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=1165051000";
		WeatherVO result = new WeatherVO();
		try {
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			
			Document doc = dBuilder.parse(urlstr);
			
			doc.getDocumentElement().normalize();
			
			NodeList data = doc.getElementsByTagName("data");
			for(int i = 0; i < data.getLength(); i++) {
				Node node = data.item(i);
				if(node.getNodeType() == Node.ELEMENT_NODE) {
					//Element element = (Element) node;
				}
			}
			
			Node node = data.item(0);
			Element element = (Element) node;
			result.setHour(element.getElementsByTagName("hour").item(0).getTextContent());
			result.setDay(element.getElementsByTagName("day").item(0).getTextContent());
			result.setTemp(element.getElementsByTagName("temp").item(0).getTextContent());
			result.setTmx(element.getElementsByTagName("tmx").item(0).getTextContent());
			result.setTmn(element.getElementsByTagName("tmn").item(0).getTextContent());
			result.setWfKor(element.getElementsByTagName("wfKor").item(0).getTextContent());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
