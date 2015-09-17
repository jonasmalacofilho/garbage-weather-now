import ForecastApi;
import js.jquery.*;
import js.jquery.Helper.*;

abstract CityStateView(js.html.DivElement) {
	public function new(name) {
		this = cast J('<div class="state" id="$name"></div>').toArray()[0];
		J(this).append('<span class="name">$name</span>');
		J(this).append('<span class="temp">―</span>');
		J("body").append(this);
	}

	public function update(forecast:Null<Forecast>)
	{
		var txt = J(this).children(".temp");
		if (forecast == null) {
			txt.text("―");
		} else {
			// TODO F vs C
			txt.text('${Math.round(forecast.main.temp - 273)} C');
		}
	}
}

class CityState {
	var view:CityStateView;

	public var name(default,null):String;
	public var forecast(default,null):Null<Forecast>;

	function set_forecast(f)
	{
		forecast = f;
		view.update(f);
		return forecast;
	}

	public function new(name)
	{
		this.name = name;
		this.view = new CityStateView(name);
		ForecastApi.asyncFetch(name, set_forecast);
		// js.Browser.window.setInterval(ForecastApi.asyncFetch, 60000, name, set_forecast);
	}

	public function toString()
		return forecast != null ? '$name: ${forecast.main.temp} K' : '$name: ―';
}

