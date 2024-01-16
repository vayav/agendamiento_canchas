import 'package:agendamiento_canchas/common/values.dart';
import 'package:agendamiento_canchas/provider/api_weather_provider.dart';
import 'package:agendamiento_canchas/provider/db_provider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardExpandedWidget extends StatefulWidget {
  const CardExpandedWidget({Key? key, required this.agendas}) : super(key: key);

  final Map agendas;

  @override
  State<CardExpandedWidget> createState() => _CardExpandedWidgetState();
}

class _CardExpandedWidgetState extends State<CardExpandedWidget> {
  var probabilidad;

  @override
  void initState() {
    super.initState();
    _obtenerProbabilidad(context, widget.agendas['fechaRegistro'])
        .then((resultado) {
      setState(() {
        probabilidad = resultado;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      iconColor: AppColors.blue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 1.0, right: 1.0, bottom: 15.0),
          child: ExpansionTileCard(
            baseColor: Colors.grey.shade200,
            // key: cardA,
            // leading: const CircleAvatar(child: Text('1')),
            title: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(
                  width: 3.0,
                ),
                Expanded(
                  child: Text(
                    widget.agendas['nombreCancha'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    Text('Fecha: ${widget.agendas['fechaRegistro']}'),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Nombre: ${widget.agendas['nombre']}',
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
              ],
            ),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    'Probabilidad de Lluvia $probabilidad%',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15),
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 52.0,
                buttonMinWidth: 90.0,
                children: <Widget>[
                  TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      _dialogBuilder(
                        context,
                        widget.agendas['fechaRegistro'],
                        widget.agendas['id'].toString(),
                      );
                    },
                    child: const Column(
                      children: <Widget>[
                        Icon(Icons.delete, color: AppColors.red),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Text(
                          'Eliminar Cita',
                          style: TextStyle(color: AppColors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _obtenerProbabilidad(context, String fecha) async {
    final sendData = Provider.of<ApiWeatherProvider>(context, listen: false);
    await sendData.getPostData(context, fecha);
    var precipitation = sendData.weatherData!.precipitation.total;
    return precipitation.toString();
  }

  Future<void> _dialogBuilder(BuildContext context, String fecha, String id) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Cita'),
          content:
              Text('Está seguro que desea eliminar la cita para el día $fecha'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Aceptar'),
              onPressed: () {
                // Navigator.of(context).pop();
                DBProvider.db.eliminarCita(id);
                Navigator.of(context)
                  ..pop()
                  ..pop();
                Navigator.pushNamed(context, '/lista_agendaciones');
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
