import 'package:agendamiento_canchas/provider/api_weather_provider.dart';
import 'package:agendamiento_canchas/screens/lista_agendas.dart';
import 'package:agendamiento_canchas/screens/registro_agenda.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiWeatherProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/lista_agendaciones',
        routes: {
          '/lista_agendaciones': (_) => const ListaAgendacionesScreen(),
          '/registro_agenda': (_) => const RegistroAgendaScreen(),
        },
      ),
    );
  }
}
