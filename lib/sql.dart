import 'package:enote/model.dart';
import 'package:sqflite/sqflite.dart';

class Sql {
  static final dbName = 'eNote.db';
  static final tableName = 'noteList';
  Database db;
  static Sql _instance;

  //创建表语句
  static var createTable = '''
  create table noteList(
    id integer primary key,
    date text not null,
    time text not null,
    eIndex integer not null,
    content text not null
  );
  ''';

  //单例
  static Future<Sql> getInstance() async {
    if (_instance == null) {
      _instance = await _initDB();
    }
    return _instance;
  }

  //判断表是否存在
  Future<bool> isTableExists(Database db, String name) async {
    var result = await db.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$name'");
    return result != null && result.length > 0;
  }

  //打开数据库
  static Future<Sql> _initDB() async {
    Sql manager = Sql();
    String dbPath = await getDatabasesPath() + '/$dbName';
    print(dbPath);
    if (manager.db == null) {
      manager.db =
          await openDatabase(dbPath, version: 1, onCreate: (db, version) async {
        if (await manager.isTableExists(db, tableName) == false) {
          await db.execute(createTable);
        }
      });
    }
    return manager;
  }

  //插入数据
  static Future<int> Insert(Model model) async {
    int res = await Sql.getInstance()
        .then((sql) => sql.db.insert(Sql.tableName, model.toMap()));
    return res;
  }

  //删除数据
  static Future<List<Map<String, dynamic>>> Query(String condition) async {
    var res = await Sql.getInstance().then((sql) => sql.db
        .rawQuery("select * from ${Sql.tableName} where " + condition + ';'));
    return res;
  }

  static Future<int> Update(Model model) async {
    int res = await Sql.getInstance().then((sql) => sql.db.update(
        Sql.tableName, model.toMap(),
        where: "id = ?", whereArgs: [model.id]));
    return res;
  }

  static Future<int> Delete(int index) async {
    int res = await Sql.getInstance().then((sql) =>
        sql.db.delete(Sql.tableName, where: "id = ?", whereArgs: [index]));
    return res;
  }
}
