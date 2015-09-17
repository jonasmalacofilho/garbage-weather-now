typedef Forecast = {
	main : {
		temp : Float,
		pressure : Float,
		humidity : Float,
		temp_min : Float,
		temp_max : Float
	},
	name : String
}

class ForecastApi {
	static function createRequest(city)
	{
		var url = 'http://api.openweathermap.org/data/2.5/weather?q=${StringTools.urlEncode(city)},br';
		var r = new haxe.Http(url);
		r.onError = function (msg) throw 'Forecast request error: $msg';
		return r;
	}

	public static function fetch(city):Forecast
	{
		var r = createRequest(city);
		r.async = false;
		r.request();
		return haxe.Json.parse(r.responseData);
	}

	public static function asyncFetch(city, handler)
	{
		var r = createRequest(city);
		r.async = true;
		r.onData = function (data) handler(haxe.Json.parse(data));
		r.request();
	}
}

