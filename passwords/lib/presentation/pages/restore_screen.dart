import 'package:flutter/material.dart';
import '../../domain/usecases/restore_usecase.dart';
import 'start_up.dart';
import '../config/constants.dart';

class RestoreScreen extends StatefulWidget {
  const RestoreScreen({super.key});

  @override
  State<RestoreScreen> createState() => _RestoreScreenState();
}

class _RestoreScreenState extends State<RestoreScreen> {

  Future<Text> restoreData() async {
    return restoreJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Text>(
      future: restoreData(),
      builder: (BuildContext context, AsyncSnapshot<Text> snapshot){
        if(snapshot.hasData) {
          return StartUp(option: StartUpScreens.home,);               
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }
}