import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'create_db.dart';
import '../../presentation/config/constants.dart';

Future<sql.Database> database() async {

  const String dbName = AppConstants.databaseName;
  try {  
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, dbName),
      version: 1,
      onCreate: (db, version) {
        List<String> sqls = CreateDataBase.getSQL();
        for (var sql in sqls) {
          db.execute(sql);
        }
      },
    );
  } catch (error) {
    rethrow;
  }

}
Future<void> cleanDatabase() async {
  try{
    
    final db = await database();
    await db.transaction((txn) async {
      var batch = txn.batch();
      batch.delete(GroupNames.tableName);
      batch.delete(TypeNames.tableName);
      batch.delete(PasswordNames.tableName); 
      await batch.commit();       
    });
  } catch(error){
    throw Exception('DbBase.cleanDatabase: ' + error.toString());
  }
}
