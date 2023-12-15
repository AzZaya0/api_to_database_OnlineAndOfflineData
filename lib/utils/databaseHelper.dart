import 'dart:io';

import 'package:api_to_database/model/postModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;
  String PostTable = 'post_table';
  String colId = 'id';
  String colTitle = 'title';
  String colPrice = 'price';
  String colDescription = 'description';
  String colCategory = 'category';
  String colImage = 'image';
  String colRating = 'rating';
  String colRate = 'rate';
  String colCount = 'count';
  DatabaseHelper._createInstant();
  factory DatabaseHelper() =>
      _databaseHelper ??= DatabaseHelper._createInstant();

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}post.db';

    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $PostTable($colId INTEGER ,$colTitle TEXT, $colPrice INTEGER,  $colDescription TEXT,$colCategory TEXT,$colImage TEXT,$colRating TEXT)');
  }

//Select all query function
  Future<List<Map<String, dynamic>>> getPostMapList() async {
    Database db = await database;
    //  var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(PostTable, orderBy: '$colId ASC');
    return result;
  }

//Insert query function
  Future<int> insertNote(Post note) async {
    Database db = await database;
    var result = await db.insert(PostTable, note.toJson());
    return result;
  }

  //get the list of model from database
  Future<List<Post>> getNoteList() async {
    var postMapList = await getPostMapList(); //select all Query
    return postMapList.map((postMap) => Post.fromDatabase(postMap)).toList();
  }
}
