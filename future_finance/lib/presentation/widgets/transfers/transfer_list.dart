import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/transfers/transfer_bloc_exports.dart';
import '../../../domain/entities/transfer.dart';
import 'transfer_widgets.dart';
import '../../config/constants.dart';
import '../../pages/transfer_screen.dart';
import '../../bloc/dialog/dialog_bloc_exports.dart';
import '../../config/injection_container.dart';

class TransfersList extends StatelessWidget {
  final List<Transfer> transfers;
  TransfersList(this.transfers);

  void _navigateAndDisplayTransfer(BuildContext context) async {

    var result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => 
      BlocProvider.value(
        value: sl<DialogBloc>(),
        child: TransferScreen(transfer: Transfer(id: 0, title: '', description: '', plannedDate: null, toAccountId: 0, fromAccountId: 0, categoryId: 0, recurrenceId: 0, amount: 0.0, usedForCashFlow: true, processed: SettingNames.autoProcessedFalse, user_id: 0), ),         
      ),
    ));
    if(result != null){
      TransferBloc ab = BlocProvider.of<TransferBloc>(context);
      ab.add(InsertTransferEvent(transfer: result as Transfer));   
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
                _navigateAndDisplayTransfer(context);
              },
            ),
          ],
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 265,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              'Transfers',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            background: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/transferD.png'),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((_, index){
            return TransferListTile(transfers[index]);
          },
          childCount: transfers.length,
          ),
        ),
      ],
    );
  }
}
