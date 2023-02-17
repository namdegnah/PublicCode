import '../../domain/entities/group.dart';
import '../../domain/entities/type.dart';
import '../../domain/entities/password.dart';

class Params {
  int id = 0, id2 = 0, id3 = 0;
  List<String> tableNames = ['abc'];
  DateTime past = DateTime.now();
  DateTime future = DateTime.now();
  Group group = Group(id: -1, name: '');
  Type type = Type(id: -1, name: '', fields: '', passwordValidationId: 1);
  Password password = Password(id: -1, groupId: -1, typeId: -1, password: '', description: '', notes: '');
  Params();
  Params.endDate({required this.id, required this.id2, required this.future});
  Params.id({required this.id});
  Params.id2({required this.id, required this.id2});
  Params.id3({required this.id, required this.id2, required this.id3});
  Params.tableNames({required this.tableNames});
  Params.date({required this.past, required this.future});
  Params.group({required this.group});
  Params.type({required this.type});
  Params.password({required this.password});
}
