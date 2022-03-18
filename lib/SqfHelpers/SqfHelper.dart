
import 'package:sqflite/sqflite.dart';

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

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE $tableName ($columnName1 INTEGER PRIMARY KEY, $columnName2 TEXT, $columnName3 INTEGER)');
        });

  }

  addData(String title,String message,) async {
    if(database==null){
      await createDb();
    }
    await database!.insert(tableName, {columnName2:title,columnName3:message});
  }

  deleteData(int id,) async {
    if(database!=null){
      return await database!.delete(tableName, where: '$columnName1 = ?', whereArgs: [id]);
    }

  }

  updateData(String title,String message,int Id) async {
    if(database!=null){
      return await database!.update(tableName, {columnName2:title,columnName3:message},
          where: '$columnName1 = ?', whereArgs: [Id]);
    }

  }


  getData({id}) async {
    if(database==null){
      await createDb();
    }
    if(database!=null){
      List<Map> maps = await database!.query(
          tableName,
          // columns: [columnName1, columnName2, columnName3],
          // where: '$columnName1 = ?',
          // whereArgs: [id]
      );
      return maps;
    }
    else{
      return [];
    }
  }

}