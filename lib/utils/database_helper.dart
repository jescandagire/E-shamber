import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:e_shamber/models/farm.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper;    //Singleton DatabaseHelper
  static Database _database;                //Singleton Database


  String farmTable = 'farm_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';

  DatabaseHelper._createInstance();  //Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper(){

    if (_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance(); //This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async{

    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    //Get the directory path for both Android and IOS TO STORE DATABASE
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'farms.db';

    //Open/create the database at a given path
    var farmsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return farmsDatabase;
  }

  void _createDb(Database db, int newVersion) async{

    await db.execute('CREATE TABLE $farmTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colDate TEXT)');
  }

  //Fetch; get all farm objects from the database
  Future<List<Map<String, dynamic>>> getFarmMapList() async{
    Database db = await this.database;

//    var result = await db.rawQuery('SELECT * FROM $farmTable order by $colDate ASC');
    var result = await db.query(farmTable, orderBy: '$colDate ASC');
    return result;
  }

  //Insert; insert a farm object to the database
  Future<int> insertFarm(Farm farm) async {
    Database db = await this.database;
    var result = await db.insert(farmTable, farm.toMap());
    return result;
  }

  //Update; update a farm object and save it to the database
  Future<int> updateFarm(Farm farm) async {
    var db = await this.database;
    var result = await db.update(farmTable, farm.toMap(), where: '$colId = ?', whereArgs: [farm.id]);
    return result;
  }

  //Delete; delete a farm object from the database
  Future<int> deleteFarm(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $farmTable WHERE $colId = $id');
    return result;
  }

  // Get number of Farm objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $farmTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Farm List' [ List<Farm> ]
  Future<List<Farm>> getFarmList() async {

    var farmMapList = await getFarmMapList(); // Get 'Map List' from database
    int count = farmMapList.length;         // Count the number of map entries in db table

    List<Farm> farmList = List<Farm>();
    // For loop to create a 'Farm List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      farmList.add(Farm.fromMapObject(farmMapList[i]));
    }

    return farmList;
  }

}