import 'package:flutter/material.dart';
import 'back_end_tests.dart';
import '../style/text_style.dart';

class TestResults extends StatelessWidget {
  TestResults({super.key});

  late List<String> dataList;

  Future<List<String>> loadResults(BuildContext context) async {
      CrudTesting at = CrudTesting();
      dataList = [];
      List<String> data = await at.testCRUD(dataList);
      return data;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: loadResults(context),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot){
        if(snapshot.hasData) {
          return finishScreen(context, snapshot.data!);               
        } else {
          return loadingScreen(context);
        }
      }
    );
  }
}
Widget finishScreen(BuildContext context, List<String> results){
  return Scaffold(
    appBar: AppBar(title: const Text('Results')),
    body: Container(
      padding: const EdgeInsets.all(20),
      child: convertList(results),
    ),
  );
}
Widget loadingScreen(BuildContext context){
  return Scaffold(
    appBar: AppBar(title: const Text('Loading')),
    body: Container(
      padding: const EdgeInsets.all(50),
      child: const Text('loading'),
    ),
  );
}
Column convertList(List<String> values){
  List<Widget> results = [];
  for(var value in values){
    results.add(Text(value, style: dashboardHi20,));
  }
  Column column = Column(
    children: results,
  );  
  return column;
}