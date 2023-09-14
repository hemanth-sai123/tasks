import 'package:flutter/cupertino.dart';

import 'db_helper.dart';

class DBServices{

  static final dbHelper = DatabaseHelper();

  static Future<DatabaseHelper> initState() async{
    await dbHelper.init();
    return dbHelper;
  }

  static void insert(Map<String, dynamic> row) async {
    // row to insert

    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  static Future<List<Map<String, dynamic>>> query() async {
    final allRows = await dbHelper.queryAllRows();
    debugPrint('query all rows:');
    for (final row in allRows) {
      debugPrint(row.toString());
    }
    return allRows;
  }




}