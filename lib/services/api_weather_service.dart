import 'dart:convert';

import 'package:agendamiento_canchas/model/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<WeatherData> apiWeather(context, String date,
    {http.Client? client}) async {
  WeatherData? weatherData;

  final httpClient = client ?? http.Client();
  try {
    final response = await httpClient.get(Uri.parse(
      'https://api.openweathermap.org/data/3.0/onecall/day_summary?lat=19.04&lon=-98.19&date=$date&appid=429a6ea260696c6ebfb360c29f6e3e1f',
    )); // Reemplaza con la URL real de la API

    if (response.statusCode == 200) {
      // La llamada a la API fue exitosa
      Map<String, dynamic> jsonMap = json.decode(response.body);
      weatherData = WeatherData.fromJson(jsonMap);

      return weatherData;
      // Puedes imprimir o utilizar los datos según tus necesidades
    } else {
      // Si la llamada a la API falla, imprime el código de estado
      const snackBar = SnackBar(
        content: Text('Ocurrió un error al obtener la probabilidad de ese día'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } catch (e) {
    debugPrint(e.toString());
    const snackBar = SnackBar(
      content: Text('Ocurrió un error al obtener la probabilidad de ese día'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } finally {
    if (client == null) {
      httpClient.close();
    }
  }
  return weatherData!;
}
