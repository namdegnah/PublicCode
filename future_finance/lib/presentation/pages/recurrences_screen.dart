import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/recurrences/recurrence_bloc_exports.dart';
import '../widgets/recurrences/recurrence_widgets.dart';
import '../widgets/common_widgets.dart';
import '../config/constants.dart';

class RecurrencesScreen extends StatefulWidget {
  @override
  _RecurrencesScreenState createState() => _RecurrencesScreenState();
}

class _RecurrencesScreenState extends State<RecurrencesScreen> {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: buildBody(context),
    );
    return scaffold;
  }
}
Builder buildBody(BuildContext context){
  BlocProvider.of<RecurrencesBloc>(context).add(GetRecurrencesEvent());
  return Builder(
    builder: (context){
      final userState = context.watch<RecurrencesBloc>().state;
      if(userState is Loading){
        return Center(child: CircularProgressIndicator(),);
      } else if (userState is RecurrencesState){
        return RecurrenceList(userState.recurrences);
      } else if (userState is RecurrenceDeleteState){
        return CanNotDelete(transactions: userState.transactions, transfers: userState.transfers, type: RecurrenceNames.single);
      }
      return Center(child: CircularProgressIndicator(),);
    }
  );
}