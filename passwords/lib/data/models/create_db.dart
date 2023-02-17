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
  static const groupSql = 'CREATE TABLE ${GroupNames.tableName}(${GroupNames.id} INTEGER PRIMARY KEY, ${GroupNames.name} TEXT )';
  static const groupIndex ='CREATE UNIQUE INDEX index_groups ON ${GroupNames.tableName}(${GroupNames.id});'; 
  static const insertGroups = '''INSERT INTO ${GroupNames.tableName}(${GroupNames.id}, ${GroupNames.name}) 
    VALUES 
    (1, "Developer"), 
    (2, "Games"), 
    (3, "Houses"), 
    (4, "Money"), 
    (5, "Personal"), 
    (6, "Job"),
    (7, "Teacher")
    ''';  
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
    ${PasswordNames.passwordValidationId} INTEGER
    )''';
  static const passwordIndex ='CREATE UNIQUE INDEX index_password ON ${PasswordNames.tableName}(${PasswordNames.id});';
  static const passwordInsert = '''INSERT INTO ${PasswordNames.tableName}
    (${PasswordNames.id}, 
    ${PasswordNames.groupId},
    ${PasswordNames.typeId},
    ${PasswordNames.password}, 
    ${PasswordNames.notes},
    ${PasswordNames.description},
    ${PasswordNames.url},
    ${PasswordNames.username},
    ${PasswordNames.email},
    ${PasswordNames.accountNumber},
    ${PasswordNames.pin},
    ${PasswordNames.sortCode},
    ${PasswordNames.digit3SecurityCode},
    ${PasswordNames.digit4SecurityCode},
    ${PasswordNames.phoneNumber},
    ${PasswordNames.name},
    ${PasswordNames.cardNumber},
    ${PasswordNames.amexCardNumber},
    ${PasswordNames.expiryDate},
    ${PasswordNames.passcode},
    ${PasswordNames.passwordValidationId})   
    VALUES 
    (1, 1, 1, "Paulb5352?", "notes", "Amazon Login", "www.amazon.co.uk", "paul_brassington", "brassington22@gmail.com", "", "5352", "", "", "07507592537", "", "", "", "", "", "", 3), 
    (2, 1, 2, "Malcome3", "notes", "BBC Login", "www.bbc.co.uk", "", "paul_brassington@hotmail.com", "", "", "506832", "", "", "Bill Bloggs", "", "", "", "", "",  5)
    ''';
  // Type
  static const typeSql = 'CREATE TABLE ${TypeNames.tableName}(${TypeNames.id} INTEGER PRIMARY KEY, ${TypeNames.name} TEXT, ${TypeNames.fields} TEXT, ${TypeNames.passwordValidationId} INTEGER)';
  static const typeIndex ='CREATE UNIQUE INDEX index_types ON ${TypeNames.tableName}(${TypeNames.id});';
  // these need to change to match the fields ie 13 values
  static const insertTypes = '''INSERT INTO ${TypeNames.tableName}(${TypeNames.id}, ${TypeNames.name}, ${TypeNames.fields}, ${TypeNames.passwordValidationId}) 
    VALUES 
    (1, "Web Logins", "11111000000000001", 4),
    (2, "Email Accounts", "11101000000000001", 4),
    (3, "Company", "11100000010000101", 5), 
    (4, "People", "01001000001000001", 3), 
    (5, "Registration Codes", "11000000000000001", 5), 
    (6, "Vehicle", "11100000000000101", 5),
    (7, "Money", "11111111110110101", 3),
    (8, "Credit Card",      "11111111101010111", 3),
    (9, "Amex Credit Card", "11111111011001111", 3),
    (10, "Bank Account", "11001111001100001", 5),
    (11, "Home", "11000000001100001", 5)    
    '''; 
  static List<String> getSQL() {
    return [groupSql, groupIndex, insertGroups, typeSql, typeIndex, insertTypes, passwordSql, passwordIndex, passwordInsert];
  }     
}