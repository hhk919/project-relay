package relay.controller.weather;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import relay.biz.weather.WeatherBIZ;
import relay.vo.weather.WeatherVO;

@RestController
public class WeatherController {
	
	@Autowired
	WeatherBIZ wBiz;
	
	@RequestMapping("/weather.do")
	public WeatherVO getWeather(){
		WeatherVO result = wBiz.getWeather();
		return result;
	}
}
