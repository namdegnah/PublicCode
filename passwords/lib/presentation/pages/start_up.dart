import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/setup/setup_bloc_events.dart';
import '../bloc/setup/setup_bloc_states.dart';
import '../bloc/setup/setup_bloc.dart';
import 'home_screen.dart';
import '../../data/models/data_set.dart';
import '../config/injection_container.dart' as di;
import '../config/constants.dart';
import '../pages/backup_screen.dart';


class StartUp extends StatelessWidget {
  const StartUp({required this.option, super.key});
  final StartUpScreens option;
  @override
  Widget build(BuildContext context) {
    return buildBody(context, option);
  }
}

Builder buildBody(BuildContext context, StartUpScreens option){
  
  late DataSet dataSet;
  BlocProvider.of<SetupBloc>(context).add(SetupRequestData());
  return Builder(
    builder: (context){
      final setupState = context.watch<SetupBloc>().state;
      if(setupState is SetupLoadingState) {
        return const Center(child: CircularProgressIndicator(),);
      } else if(setupState is SetupDataState){  
        // so here we have the data  
        if(setupState.dataSet.passwordFields != null){
          dataSet = setupState.dataSet;
          di.sl<DataSet>().passwordFields = setupState.dataSet.passwordFields;
          di.sl<DataSet>().passwords = setupState.dataSet.passwords;
          di.sl<DataSet>().types = setupState.dataSet.types;
          di.sl<DataSet>().groups = setupState.dataSet.groups;
        } 
        switch(option){
          case StartUpScreens.home: 
            return HomeScreen();
          case StartUpScreens.backup:
            return BackupScreen(dataSet: dataSet);
        }
      }
      return const Center(child: CircularProgressIndicator(),);
    },
  );
}