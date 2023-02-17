import 'package:flutter/material.dart';
import '../../bloc/recurrences/recurrence_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecurrencesSendEvent extends StatelessWidget {
  RecurrencesSendEvent();
  
  @override
  Widget build(BuildContext context) {
    
    BlocProvider.of<RecurrencesBloc>(context).add(GetRecurrencesEvent());
    return const SizedBox(height: 1);      
  }
}