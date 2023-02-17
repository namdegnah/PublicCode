import 'package:flutter/material.dart';
import '../../../bloc/accounts/account_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/injection_container.dart';

class AccountsSendEvent extends StatelessWidget {
  AccountsSendEvent();
    
  @override
  Widget build(BuildContext context) {
    
    BlocProvider.of<AccountsBloc>(context).add(GetAccountsEvent());  
    return const SizedBox(height: 1);      
  }

}