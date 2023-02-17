import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/accounts/plain/accounts_list.dart';
import '../bloc/accounts/account_bloc_exports.dart';
import '../widgets/accounts/plain/account_widgets.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: buildBody(context),
    );
    return scaffold;
  }
}
Builder buildBody(BuildContext context){
  BlocProvider.of<AccountsBloc>(context).add(GetAccountsEvent());
  return Builder(
    builder: (BuildContext context){
      final userState = context.watch<AccountsBloc>().state;
      if(userState is Loading){
        return Center(child: CircularProgressIndicator(),);
      } else if (userState is AccountsDialogState){
        // sl<AccountUser>().accounts = userState.db.accounts; //why is this necessary, bit of a fudge, but was needed
        return AccountList(db: userState.db,);
      }
      return Center(child: CircularProgressIndicator(),);
    }
  );
}
