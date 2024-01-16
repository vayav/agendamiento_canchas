import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    // Path donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'RegistroAgendas.db');
    print(path);

    // Crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (
      Database db,
      int version,
    ) async {
      await db.execute(''' 
        CREATE TABLE Agendas(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombreCancha TEXT,
          fechaRegistro DATE,
          nombre TEXT
        )
      ''');
    });

    // Initizialize the notificatio
  }

  registroAgendas(
    String nombreCancha,
    String fecha,
    String nombrePersona,
  ) async {
    // Verificar la base de datos
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Agendas(nombreCancha, fechaRegistro, nombre)
      VALUES ('$nombreCancha', '$fecha', '$nombrePersona')
    ''');

    return res;
  }

  Future<List<Map>> getAllScan() async {
    final db = await database;
    final res =
        await db.rawQuery('SELECT * FROM Agendas ORDER BY fechaRegistro ASC');

    List<Map> result = res;

    return result;
  }

  Future<bool> validarMaximoAgendamiento(
    String nombreCancha,
    String fecha,
  ) async {
    final db = await database;

    final res = await db.rawQuery('''
      SELECT * FROM Agendas WHERE nombreCancha = '$nombreCancha' AND fechaRegistro = '$fecha'
    ''');

    List<Map> result = res;

    return result.length >= 3;
  }

  eliminarCita(
    String id,
  ) async {
    // Verificar la base de datos
    final db = await database;

    final res = await db.rawInsert('''
      DELETE FROM Agendas WHERE id = $id
    ''');

    return res;
  }
}
