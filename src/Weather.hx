import js.jquery.Helper.*;

class Weather {
	static function main()
	{
		JTHIS.ready(function() {
			trace("hi");
			var capitals = ["São Paulo", "Rio de Janeiro", "Brasília"];
			var states = [for (c in capitals) new CityState(c)];
			trace(states);
		});
	}
}

