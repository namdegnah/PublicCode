import '../../domain/entities/password_field.dart';
import '../../domain/entities/group.dart';
import '../../domain/entities/type.dart';
import '../../domain/entities/password.dart';

class DataSet{
  List<PasswordField>? passwordFields;
  List<Group>? groups;
  List<Type>? types;
  List<Password>? passwords;

  DataSet({this.passwordFields, this.groups, this.types, this.passwords});
}