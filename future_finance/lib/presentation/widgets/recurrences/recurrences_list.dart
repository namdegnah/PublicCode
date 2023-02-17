import 'package:flutter/material.dart';
import '../../config/injection_container.dart';
import '../../bloc/recurrences/recurrence_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../pages/recurrence_screen.dart';
import '../../../domain/entities/recurrence.dart';
import '../../widgets/recurrences/recurrence_widgets.dart';


class RecurrenceList extends StatelessWidget {
  final List<Recurrence> recurrences;
  RecurrenceList(this.recurrences);
  
  void _navigateAndDisplayRecurrence(BuildContext context) async {

    var result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => 
      BlocProvider.value(
        value: sl<RecurrencesBloc>(),
        child: RecurrenceScreen(recurrence: Recurrence(id: 0, title: '', description: '', type: 1, iconPath: '', endDate: null, noOccurences: null),),
      ),
    ));
    if(result != null){
      RecurrencesBloc rb = BlocProvider.of<RecurrencesBloc>(context);
      rb.add(InsertRecurrenceEvent(recurrence: result as Recurrence));   
    }
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          iconTheme: IconThemeData(color: Colors.black26),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _navigateAndDisplayRecurrence(context);
              },
            ),
          ],
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 265,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              'Recurrences',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            background: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/recurrence.jpg'),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((_, index){
            return RecurrenceListTile(recurrences[index]);
          },
          childCount: recurrences.length,
          ),
        ),
      ],
    );    
  }
}
