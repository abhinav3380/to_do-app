import 'package:sqflite/sqflite.dart';

class Homescreencontroller {
  static late Database database;
  static List<Map> MyTaskList = [];
  static Future<void> initDb() async {
    
    database = await openDatabase("myDb.db", version: 1,
        onCreate: (Database db, int version) async {
      
      await db.execute(
          'CREATE TABLE Task (id INTEGER PRIMARY KEY, name TEXT, date TEXT)');
    });
  }

 
  static Future<void> addData(
      {required String tasks, required String dates}) async {
    await database.rawInsert(
        'INSERT INTO Task (name,date) VALUES(? , ?)', [tasks, dates]);
    getData();
  }

  static Future<void> getData() async {
    
    List<Map> list = await database.rawQuery('SELECT * FROM Task');
    MyTaskList = list;
    getData();
  }


  static Future<void> deleteData({required int deletetask}) async {
    await database.rawDelete('DELETE FROM Task WHERE id = ?', [deletetask]);
    getData();
  }

  
  static Future<void> editData(
      {required int id,
      required String name,
      required String task}) async {
    await database.rawUpdate(
        'UPDATE Task SET name = ?,  date = ? WHERE id = ?',
        [name, task, id]);
    getData();
  }
}