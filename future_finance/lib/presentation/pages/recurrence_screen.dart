import 'package:flutter/material.dart';
// import '../bloc/recurrences/recurrence_bloc_exports.dart';

import '../../domain/entities/recurrence.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/recurrences/recurrence_widgets.dart';

class RecurrenceScreen extends StatelessWidget {
  final Recurrence recurrence;
  RecurrenceScreen({required this.recurrence});
  final form = GlobalKey<FormState>();
  
  void _saveForm(BuildContext context){
    if(recurrence.type == null){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text('Select a type'), 
        content: Text('e.g. weekly, monthly etc.'), 
        actions: <Widget>[
          TextButton(
            child: Text('OK'), 
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
      return;
    }    
    final isValid = form.currentState!.validate();
    if(!isValid) return;
    form.currentState!.save();
    Navigator.pop(context, recurrence);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recurrence'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(context),
            ),
        ],
        ),
      body: RecurrenceWidget(recurrence, form, _saveForm),            
    );
  }
}