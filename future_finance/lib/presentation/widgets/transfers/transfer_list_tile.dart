import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/injection_container.dart';
import '../../../domain/entities/transfer.dart';
import '../../bloc/transfers/transfer_bloc_exports.dart';
import '../../pages/transfer_screen.dart';
import '../../bloc/dialog/dialog_bloc_exports.dart';

class TransferListTile extends StatelessWidget {
  final Transfer transfer;
  TransferListTile(this.transfer);
  late int id;

  void _deleteTransfer(BuildContext context, int id) {

    TransferBloc tb = BlocProvider.of<TransferBloc>(context);
    tb.add(DeleteTransferEvent(id: id));   
  }

  void _navigateAndDisplayTransfer(BuildContext context, int id) async {

    var result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => 
      BlocProvider.value(
        value: sl<DialogBloc>(),
        child: TransferScreen(transfer: transfer,), 
      ),
    ));
    if(result != null){
      BlocProvider.of<TransferBloc>(context).add(UpdateTransferEvent(transfer: result as Transfer)); 
    }
  }
   
  @override
  Widget build(BuildContext context) {
    
    id = transfer.id;
    return 
      Column(children: <Widget>[     
        ListTile(
          leading: null,//Whaat do we want
          title: Text(transfer.title),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _navigateAndDisplayTransfer(context, id),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteTransfer(context,id),
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