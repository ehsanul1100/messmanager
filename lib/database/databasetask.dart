
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TasksDatabase{
  static const String _databaseName = 'messmanager.db';
  static const int _databaseVersion = 1;

  //Create  a singlton

  const TasksDatabase._privateConstructor();
  static const TasksDatabase instance = TasksDatabase._privateConstructor();
  static Database? _database;

  Future<Database> get database async{
    if(_database == null) {
      _database = await _initDatabase();
      return _database!;
    }
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String  dbPath = await getDatabasesPath();
    final String path = join(dbPath,_databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDB
      );
  }

  Future _createDB(
    Database db,
    int version,
  ) async {
    // const textType = 'TEXT NOT NULL';
    // const boolType = 'BOOLEAN NOT NULL';
  }
  //! c--> crud = create

  
}