
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_implementation/Models/DiaryModel.dart';

class SqfHelper{
  Database? database;

  String tableName="testTable";
  String columnName1="Id";
  String columnName2="title";
  String columnName3="message";

  createDb() async {
    String databasesPath = await getDatabasesPath();
    String path=databasesPath+"/test.db";
    print(path);

    // await deleteDatabase(path);
    // print(path);

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE $tableName ($columnName1 INTEGER PRIMARY KEY, $columnName2 TEXT, $columnName3 INTEGER)');
        });

  }

  addData(String title,String message) async {
    if(database==null){
      await createDb();
    }
    // database!.insert(tableTodo, todo.toMap());
    await database!.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO $tableName($columnName2, $columnName3) VALUES("$title", "$message")');
      print('inserted1: $id1');
      // int id2 = await txn.rawInsert(
      //     'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
      //     ['another name', 12345678, 3.1416]);
      // print('inserted2: $id2');
    });
  }

  deleteData(int id,) async {
    if(database!=null){
      await database!.transaction((txn) async {
        int id1 = await txn
            .rawDelete('DELETE FROM $tableName WHERE $columnName1 = ?', [id]);
        print('deleted: $id1');
        // int id2 = await txn.rawInsert(
        //     'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
        //     ['another name', 12345678, 3.1416]);
        // print('inserted2: $id2');
      });
    }

  }

  updateData(String title,String message) async {

    if(database!=null){
      int count = await database!.rawUpdate(
          'UPDATE $tableName SET $columnName2 = ?, value = ? WHERE name = ?',
          ['updated name', '9876', 'some name']);
    }

  }


  getData() async {
    if(database==null){
      await createDb();
    }
    if(database!=null){
      List<Map> list = await database!.rawQuery('SELECT * FROM $tableName');
      // List<DiaryModel> diaryList=list.map((e) => DiaryModel.fromDb(e)).toList();
      return list;
    }
    else{
      return [];
    }
  }

}