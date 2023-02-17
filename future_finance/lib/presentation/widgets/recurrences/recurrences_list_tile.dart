import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/recurrence.dart';
import '../../config/injection_container.dart';
import '../../bloc/recurrences/recurrence_bloc_exports.dart';
import '../../pages/recurrence_screen.dart';
import '../common_widgets.dart';

class RecurrenceListTile extends StatelessWidget {
  final Recurrence recurrence;
  RecurrenceListTile(this.recurrence);
  late int id;
  var result;

  void _deleteRecurrence(BuildContext context, int id) {

    BlocProvider.of<RecurrencesBloc>(context).add(DeleteRecurrenceEvent(id: id));  
  }
  void _navigateAndDisplayRecurrence(BuildContext context, int id) async {

    var result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => 
      BlocProvider.value(
        value: sl<RecurrencesBloc>(),
        child: RecurrenceScreen(recurrence: recurrence,), 
      ),
    ));
    if(result != null){
      RecurrencesBloc rb = BlocProvider.of<RecurrencesBloc>(context);
      rb.add(UpdateRecurrenceEvent(recurrence: result as Recurrence));   
    }
  }

  Widget _getIcon(){
    return IconListImage(recurrence.iconPath, 35);   
  }
   
  @override
  Widget build(BuildContext context) {
    
    id = recurrence.id;
    return 
      Column(children: <Widget>[     
        ListTile(
          // leading: Text(account.id.toString()),
          leading: _getIcon(),
          title: Text(recurrence.title),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _navigateAndDisplayRecurrence(context, id),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteRecurrence(context,id),
                ),
              ],
            ),
          ),
        ),
       const Divider(height: 2, thickness: 2,)
      ],
    );
  }
}