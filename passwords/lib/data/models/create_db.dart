import '../../presentation/config/constants.dart';

class CreateDataBase {
  static List<String> sqls = [];
  static List<String> getSQL() {
    sqls.addAll(AppSQL.getSQL());
    return sqls;
  }
}

class AppSQL {
  // Group
  static const groupSql =
      'CREATE TABLE ${GroupNames.tableName}(${GroupNames.id} INTEGER PRIMARY KEY, ${GroupNames.name} TEXT )';
  // Password
  static const passwordSql = '''CREATE TABLE ${PasswordNames.tableName}(
    ${PasswordNames.id} INTEGER PRIMARY KEY, 
    ${PasswordNames.groupId} INTEGER, 
    ${PasswordNames.typeId} INTEGER,
    ${PasswordNames.password} TEXT, 
    ${PasswordNames.notes} TEXT,
    ${PasswordNames.description} TEXT,
    ${PasswordNames.url} TEXT,
    ${PasswordNames.username} TEXT,
    ${PasswordNames.email} TEXT,
    ${PasswordNames.accountNumber} TEXT,
    ${PasswordNames.pin} TEXT,
    ${PasswordNames.sortCode} TEXT,
    ${PasswordNames.digit3SecurityCode} TEXT,
    ${PasswordNames.digit4SecurityCode} TEXT,
    ${PasswordNames.phoneNumber} TEXT,
    ${PasswordNames.name} TEXT,
    ${PasswordNames.cardNumber} TEXT,
    ${PasswordNames.amexCardNumber} TEXT,
    ${PasswordNames.expiryDate} TEXT,
    ${PasswordNames.passcode} TEXT,
    ${PasswordNames.passwordValidationId} INTEGER,
    ${PasswordNames.isValidated} INTEGER    
    )''';
  // Type
  static const typeSql =
      'CREATE TABLE ${TypeNames.tableName}(${TypeNames.id} INTEGER PRIMARY KEY, ${TypeNames.name} TEXT, ${TypeNames.fields} TEXT, ${TypeNames.passwordValidationId} INTEGER)';
  static List<String> getSQL() {
    return [
      groupSql,
      typeSql,
      passwordSql
    ];
  }
}
