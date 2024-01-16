import 'package:agendamiento_canchas/model/weather_model.dart';
import 'package:agendamiento_canchas/services/api_weather_service.dart';
import 'package:flutter/foundation.dart';

class ApiWeatherProvider with ChangeNotifier {
  WeatherData? weatherData;
  bool loading = false;

  getPostData(
    context,
    String date,
  ) async {
    loading = true;
    weatherData = await apiWeather(context, date);
    loading = false;
    notifyListeners();
  }
}
