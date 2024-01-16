import 'package:agendamiento_canchas/common/values.dart';
import 'package:agendamiento_canchas/provider/api_weather_provider.dart';
import 'package:agendamiento_canchas/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegistroAgendaScreen extends StatefulWidget {
  const RegistroAgendaScreen({Key? key}) : super(key: key);

  @override
  State<RegistroAgendaScreen> createState() => _RegistroAgendaScreenState();
}

class _RegistroAgendaScreenState extends State<RegistroAgendaScreen> {
  var height, width;

  String? selectedCancha;

  // final TextEditingController _cancha = TextEditingController();
  final TextEditingController _fecha = TextEditingController();
  final TextEditingController _nombre = TextEditingController();

  final List<String> nombreCanchas = [
    'Cancha A',
    'Cancha B',
    'Cancha C',
  ];
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Registra una Agenda',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.blue,
          width: width,
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 250, 250, 250),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  height: height * 0.8,
                  width: width,
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: Stack(
                      children: <Widget>[
                        Form(
                          key: myFormKey,
                          child: ListView(
                            padding: EdgeInsets.symmetric(
                              horizontal: responsive.wp(8),
                            ),
                            children: [
                              SizedBox(
                                height: responsive.hp(5),
                              ),
                              SizedBox(
                                // height: 55,
                                child: CustomSelectedInput(
                                  listaItems: nombreCanchas,
                                  selected: (value) {
                                    selectedCancha = value;
                                  },
                                  text: 'Nombre de la Cancha',
                                ),
                              ),
                              SizedBox(
                                height: responsive.hp(2),
                              ),
                              CustomTextFormField(
                                onTap: _seleccionarFecha,
                                // height: 56,
                                contentPadding: const EdgeInsets.all(17.5),
                                hintText: 'Selecciona la fecha a Agendar',
                                control: _fecha,
                                readOnly: true,
                                validator: validateEmptyText,
                                textInputType: TextInputType.text,
                                border: Borders.customOutlineInputBorder(),
                                enabledBorder:
                                    Borders.customOutlineInputBorder(),
                                focusedBorder: Borders.customOutlineInputBorder(
                                  color: AppColors.violetShade200,
                                ),
                                labelStyle: Styles.customTextStyle(),
                                hintTextStyle: Styles.customTextStyle(),
                                textStyle: Styles.customTextStyle(),
                              ),
                              SizedBox(
                                height: responsive.hp(2),
                              ),
                              CustomTextFormField(
                                // height: 56,
                                contentPadding: const EdgeInsets.all(17.5),
                                hintText: 'Escribe tu nombre por favor',
                                control: _nombre,
                                validator: validateEmptyText,
                                textInputType: TextInputType.text,
                                border: Borders.customOutlineInputBorder(),
                                enabledBorder:
                                    Borders.customOutlineInputBorder(),
                                focusedBorder: Borders.customOutlineInputBorder(
                                  color: AppColors.violetShade200,
                                ),
                                labelStyle: Styles.customTextStyle(),
                                hintTextStyle: Styles.customTextStyle(),
                                textStyle: Styles.customTextStyle(),
                              ),
                              SizedBox(
                                height: responsive.hp(5),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: _buttonRegisterAnimated(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? pickedFecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 120)),
    );

    if (pickedFecha != null && pickedFecha != DateTime.now()) {
      // Formatear la fecha seleccionada al formato 'yyyy-MM-dd'
      final sendData = Provider.of<ApiWeatherProvider>(context, listen: false);
      String formattedFecha = DateFormat('yyyy-MM-dd').format(pickedFecha);

      // Pasar la fecha al controlador
      _fecha.text = formattedFecha;
      await sendData.getPostData(context, formattedFecha);
      var precipitation = sendData.weatherData!.precipitation.total;
      // print("Precipitacion para ese día: $precipitation");
      _dialogBuilder(context, precipitation.toString());
      // También puedes hacer cualquier otra cosa con la fecha seleccionada
      // o llamar a una función para manejarla.
    }
  }

  String? validateEmptyText(String? value) {
    return value!.isEmpty ? 'El campo no puede estar vacío' : null;
  }

  Widget _buttonRegisterAnimated(BuildContext context) => ArgonButton(
        // colorBrightness: Brightness.dark,
        borderRadius: 30.0,
        height: 55,
        // roundLoadingShape: true,
        width: 300,
        onTap: (startLoading, stopLoading, btnState) {
          FocusScope.of(context).requestFocus(FocusNode());
          if (!myFormKey.currentState!.validate()) {
            const snackBar = SnackBar(
              content: Text('Por favor completa todos los campos'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            // print('Formulario no valido');
            return;
          }
          startLoading();
          Future.delayed(const Duration(seconds: 2), () async {
            stopLoading();

            // print("registro exitoso");

            if (await DBProvider.db
                .validarMaximoAgendamiento(selectedCancha!, _fecha.text)) {
              const snackBar = SnackBar(
                content: Text(
                    'Cada cancha puede ser agendada máximo tres veces en un día específico'),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }

            DBProvider.db.registroAgendas(
              selectedCancha!,
              _fecha.text,
              _nombre.text,
            );

            const snackBar = SnackBar(
              content: Text('Nuevo Medicamento Guardado'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            Navigator.of(context)
              ..pop()
              ..pop();
            Navigator.pushNamed(context, '/lista_agendaciones');
            // Navigator.of(context).popAndPushNamed('/lista_agendaciones');
            // print("Frecuencia: ${_fechaText.text}");
            // print("Horario: ${reminderTime.text}");
            // print("Primera Toma: ${primeraToma.text}");
            // print("Dosis: $selectedMedicamento");
            // print("Confirmacion Toma: $selectedConfirmacionToma");
            // Navigator.pushReplacementNamed(context, '/camera_screen');
          });
        },
        loader: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white,
            ),
          ),
        ),
        color: AppColors.blue,
        // borderRadius: 5.0,
        child: const Text(
          "Registrar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  Future<void> _dialogBuilder(BuildContext context, String lluvia) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Probabilidad de Lluvia'),
          content:
              Text('La probablidad de lluvia para ese dia es del $lluvia%'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
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
