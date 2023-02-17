import 'package:flutter/material.dart';
import '../bloc/dialog/dialog_bloc_exports.dart';
import '../../domain/entities/transfer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/transfers/transfer_widgets.dart';
import '../../data/models/dialog_base.dart';

class TransferScreen extends StatelessWidget {
  final Transfer transfer;
  TransferScreen({required this.transfer});
  final form = GlobalKey<FormState>();
  late DialogBase db;
  late DialogBloc tb;

  void _saveForm(BuildContext context){ 
    if(transfer.plannedDate == null){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select a planned date'), content: Text('e.g. Transfer must occur at a specific date'), actions: <Widget>[TextButton(child: Text('OK'), onPressed: (){Navigator.of(context).pop();},),],),);
      return;
    }
    if(transfer.toAccountId == 0){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select a to account'), content: Text('e.g. Transfer must be linked to an account the money goes to'), actions: <Widget>[TextButton(child: Text('OK'), onPressed: (){Navigator.of(context).pop();},),],),);
      return;
    } 
    if(transfer.fromAccountId == 0){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select a from account'), content: Text('e.g. Transfer must be linked to an account the money goes from'), actions: <Widget>[TextButton(child: Text('OK'), onPressed: (){Navigator.of(context).pop();},),],),);
      return;
    }       
    if(transfer.categoryId == 0){
      showDialog(context: context, builder: (context) => AlertDialog(title: Text('Select a category'), content: Text('e.g. Transfer must have a category'), actions: <Widget>[TextButton(child: Text('OK'), onPressed: (){Navigator.of(context).pop();},),],),);
      return;
    }            
    final isValid = form.currentState!.validate();
    if(!isValid) return;
    form.currentState!.save();
    Navigator.pop(context, transfer);
  }
  void _getDiaialogData(){
    tb.add(DialogFullEvent());
  }

  Builder buildBody(BuildContext context){
  return Builder(
    builder: (context){
      final userState = context.watch<DialogBloc>().state;
      if(userState is DialogFullState){
        db = userState.data;
        return TransferWidget(transfer: transfer, form: form, saveF: _saveForm, db: db);     
      } else if (userState is Loading){
        return Center(child: CircularProgressIndicator(),);
      }
      return Center(child: CircularProgressIndicator(),);
    }
  );
}
  @override
  Widget build(BuildContext context) {
    tb = BlocProvider.of<DialogBloc>(context);
    _getDiaialogData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(context),
            ),
        ],
      ),
      body: buildBody(context), 
    );
  }
}