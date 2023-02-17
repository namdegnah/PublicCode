import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_drawer.dart';
import '../bloc/facts/facts_bloc_exports.dart';
import '../widgets/facts/facts_widgets_export.dart';
import '../widgets/facts/set_scaler.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Future Finance Home Page'),
      ),
      drawer: AppDrawer(),
      body: buildBody(context),
    );
    return scaffold;
  }
}

Builder buildBody(BuildContext context){
  set_scaler(context);
  BlocProvider.of<FactsBloc>(context).add(RunPauseEvent());
  return Builder(
    builder: (context){
      final userState = context.watch<FactsBloc>().state;
      if(userState is Error){
        return ErrorHander(message: userState.message);
      }
      if(userState is Loading) {
        return Center(child: CircularProgressIndicator(),);
      } else if(userState is FactsState){      
        return FactsPage(factsbase: userState.factsBase);
      } else if(userState is RunPauseState){
            Orientation orientation = MediaQuery.of(context).orientation;
            if (orientation == Orientation.portrait) {
              return FactsHome(factsbase: userState.factsBase,);   
            } else {
              return FactsHomeLandscape(factsbase: userState.factsBase,); 
            }
      }
      return Center(child: CircularProgressIndicator(),);
    },
  );
}

class ErrorHander extends StatelessWidget {
  final String message;
  const ErrorHander({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(message),  
    );
  }
}