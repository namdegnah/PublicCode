import 'package:flutter/material.dart';

import '../../bloc/transfers/transfer_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransfersSendEvent extends StatelessWidget {
  TransfersSendEvent();
  
  @override
  Widget build(BuildContext context) {
    
    BlocProvider.of<TransferBloc>(context).add(GetTransfersEvent());  
    return Container(width: 0.0, height: 0.0,);      
  }
}