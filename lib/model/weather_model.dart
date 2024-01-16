class WeatherData {
  double lat;
  double lon;
  String tz;
  String date;
  String units;
  CloudCover cloudCover;
  Humidity humidity;
  Precipitation precipitation;
  Temperature temperature;
  Pressure pressure;
  Wind wind;

  WeatherData({
    required this.lat,
    required this.lon,
    required this.tz,
    required this.date,
    required this.units,
    required this.cloudCover,
    required this.humidity,
    required this.precipitation,
    required this.temperature,
    required this.pressure,
    required this.wind,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      lat: json['lat'],
      lon: json['lon'],
      tz: json['tz'],
      date: json['date'],
      units: json['units'],
      cloudCover: CloudCover.fromJson(json['cloud_cover']),
      humidity: Humidity.fromJson(json['humidity']),
      precipitation: Precipitation.fromJson(json['precipitation']),
      temperature: Temperature.fromJson(json['temperature']),
      pressure: Pressure.fromJson(json['pressure']),
      wind: Wind.fromJson(json['wind']),
    );
  }
}

class CloudCover {
  double afternoon;

  CloudCover({required this.afternoon});

  factory CloudCover.fromJson(Map<String, dynamic> json) {
    return CloudCover(
      afternoon: json['afternoon'],
    );
  }
}

class Humidity {
  double afternoon;

  Humidity({required this.afternoon});

  factory Humidity.fromJson(Map<String, dynamic> json) {
    return Humidity(
      afternoon: json['afternoon'],
    );
  }
}

class Precipitation {
  double total;

  Precipitation({required this.total});

  factory Precipitation.fromJson(Map<String, dynamic> json) {
    return Precipitation(
      total: json['total'],
    );
  }
}

class Temperature {
  double min;
  double max;
  double afternoon;
  double night;
  double evening;
  double morning;

  Temperature({
    required this.min,
    required this.max,
    required this.afternoon,
    required this.night,
    required this.evening,
    required this.morning,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return Temperature(
      min: json['min'],
      max: json['max'],
      afternoon: json['afternoon'],
      night: json['night'],
      evening: json['evening'],
      morning: json['morning'],
    );
  }
}

class Pressure {
  double afternoon;

  Pressure({required this.afternoon});

  factory Pressure.fromJson(Map<String, dynamic> json) {
    return Pressure(
      afternoon: json['afternoon'],
    );
  }
}

class Wind {
  MaxWind max;

  Wind({required this.max});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      max: MaxWind.fromJson(json['max']),
    );
  }
}

class MaxWind {
  double speed;
  double direction;

  MaxWind({required this.speed, required this.direction});

  factory MaxWind.fromJson(Map<String, dynamic> json) {
    return MaxWind(
      speed: json['speed'],
      direction: json['direction'],
    );
  }
}
