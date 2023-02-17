import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transfers/transfer_bloc_exports.dart';
//import '../../injection_container.dart';
import '../widgets/transfers/transfer_widgets.dart';


class TransfersScreen extends StatefulWidget {
  @override
  _TransfersScreenState createState() => _TransfersScreenState();
}

class _TransfersScreenState extends State<TransfersScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: buildBody(context),
      );
  }
}
Builder buildBody(BuildContext context){
  BlocProvider.of<TransferBloc>(context).add(GetTransfersEvent());
  return Builder(
    builder: (context) {
      final userState = context.watch<TransferBloc>().state;
      if(userState is Loading){
        return Center(child: CircularProgressIndicator(),);
      } else if(userState is TransfersState){
        return TransfersList(userState.transfers);
      }
      return Center(child: CircularProgressIndicator(),);
    },
  );
}