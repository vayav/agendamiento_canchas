import 'package:agendamiento_canchas/common/values.dart';
import 'package:agendamiento_canchas/provider/db_provider.dart';
import 'package:agendamiento_canchas/widgets/lista_agendas_widgets/card_expanded_agenda.dart';
import 'package:flutter/material.dart';

class ListaAgendacionesScreen extends StatefulWidget {
  const ListaAgendacionesScreen({Key? key}) : super(key: key);

  @override
  State<ListaAgendacionesScreen> createState() =>
      _ListaAgendacionesScreenState();
}

class _ListaAgendacionesScreenState extends State<ListaAgendacionesScreen> {
  var height, width;

  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DBProvider.db.database;

    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Citas Agendadas',
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
                  child: FutureBuilder<List<Map>>(
                    future: DBProvider.db.getAllScan(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.hasData) {
                        List<Map> agendas = snapshot.data ?? [];
                        if (agendas.isEmpty) {
                          return const Center(
                            child: Text("No tienes Citas Agendadas Todavía"),
                          );
                        }
                        return ListView.builder(
                          itemCount: agendas.length,
                          itemBuilder: (context, index) {
                            Map agenda = agendas[index];
                            return Column(
                              children: [
                                SizedBox(height: height * 0.02),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: Sizes.MARGIN_20,
                                  ),
                                  child: CardExpandedWidget(agendas: agenda),
                                  // child: const CardExpandedWidget(),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return const Center(
                        child: Text("No tienes Citas Agendadas Todavía"),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/registro_agenda');
        },
        tooltip: 'Increment',
        backgroundColor: AppColors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
