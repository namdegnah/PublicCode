import '../../entities/temp_convert/money_bank_account.dart';
import 'package:flutter/services.dart';
import '../../entities/password.dart';
import '../../entities/group.dart';
import '../../entities/type.dart';
import '../../../presentation/config/injection_container.dart';
import '../../../data/models/data_set.dart';
import '../../../presentation/bloc/password/password_bloc.dart';
import '../../../presentation/bloc/password/password_bloc_events.dart';

Future<void> convertMoneyBankAccount() async {

  List<Password> passwords = [];
  var jsonText = await rootBundle.loadString('assets/json/moneybankaccount.json');
  List<MoneyBankAccount> data = modelMBAomJson(jsonText);
  DataSet dataSet = sl<DataSet>();
  Group group = dataSet.groups!.firstWhere((element) => element.name.compareTo(data.first.group) == 0);
  Type type = dataSet.types!.firstWhere((element) => element.name.compareTo(data.first.type) == 0);

  for(var item in data){
    passwords.add(
      Password(
        id: -1, 
        groupId: group.id, 
        typeId: type.id, 
        password: item.password, 
        notes: item.notes, 
        description: item.description,
        name: item.name,
        phoneNumber: item.phoneNumber,
        passcode: item.passcode,
        pin: item.pin,
        sortCode: item.sortCode,
        accountNumber: '${item.accountNumber}',
      )
    );
  }
  for(var password in passwords){
    sl<PasswordBloc>().add(InsertBlindPasswordEvent(password: password));
  }
}