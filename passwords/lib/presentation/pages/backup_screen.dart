import 'package:flutter/material.dart';
import 'package:passwords/presentation/pages/home_screen.dart';
import '../../domain/usecases/backup_usecase.dart';
import '../../data/models/data_set.dart';

// This should use a FutureBuider as it calls a future, ie the gap.
class BackupScreen extends StatefulWidget {
  const BackupScreen({required this.dataSet, super.key});
  
  final DataSet dataSet;

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {

  Future<Text> backupData() async {
    
    return backupDataToJson(widget.dataSet);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Text>(
      future: backupData(),
      builder: (BuildContext context, AsyncSnapshot<Text> snapshot){
        if(snapshot.hasData) {
          return HomeScreen();               
        } else {
          return CircularProgressIndicator();
        }
      }
    );
  }
  
}