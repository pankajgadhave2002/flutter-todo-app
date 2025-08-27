import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{

DatabaseHelper._privateConstructor();
static final DatabaseHelper getInstance = DatabaseHelper._privateConstructor();

static final String task_db="task_database.db";
static final String task_table="task_tb";
static final String column_srno="srno";
static final String column_title="title";
static final String column_disc="discription";
static final String column_date="date";

Database? taskDB;

Future<Database?> getDB()async{
  if(taskDB!=null){
    return taskDB!;
  }else{
    taskDB=await openDB();
    return taskDB!;
  }
}

Future<Database> openDB()async{
  Directory appDir= await getApplicationDocumentsDirectory();
  String dbpath=join(appDir.path,task_db);
  return openDatabase(dbpath,onCreate: (db, version) {
    db.execute("create table $task_table ($column_srno integer primary key autoincrement,$column_title text,$column_disc text,$column_date text)");
      
    
  },version: 1,
  );

}

Future<bool> addTask({
  required String mTitle,required String mDiscription,required String mDate})async{
      var db=await getDB();
     int rowseffected= await db!.insert(task_table, {column_title:mTitle,column_disc:mDiscription,column_date:mDate});
     return rowseffected>0;
}
Future<List<Map<String, Object?>>> getALLTask()async{
  var db=await getDB();
  Future<List<Map<String, Object?>>>  mdata=  db!.query(task_table);
  return mdata;
}

}