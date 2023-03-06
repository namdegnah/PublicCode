

class Params {
  int id = 0, id2 = 0, id3 = 0;
  List<String> tableNames = ['abc'];
  DateTime past = DateTime.now();
  DateTime future = DateTime.now();
  Params();
  Params.endDate({required this.id, required this.id2, required this.future});
  Params.id({required this.id});
  Params.id2({required this.id, required this.id2});
  Params.id3({required this.id, required this.id2, required this.id3});
  Params.tableNames({required this.tableNames});

}
