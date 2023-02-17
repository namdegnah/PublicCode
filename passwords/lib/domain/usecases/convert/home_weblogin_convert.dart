import 'package:passwords/presentation/config/constants.dart';

import '../../entities/temp_convert/homes_weblogin.dart';
import 'package:flutter/services.dart';
import '../../entities/password.dart';
import '../../entities/group.dart';
import '../../entities/type.dart';
import '../../../presentation/config/injection_container.dart';
import '../../../data/models/data_set.dart';
import '../../../presentation/bloc/password/password_bloc.dart';
import '../../../presentation/bloc/password/password_bloc_events.dart';

Future<void> convertHomesWebLogin() async {

  List<Password> passwords = [];
  var jsonText = await rootBundle.loadString('assets/json/homes_weblogin.json');
  List<HomesWebLogin> data = modelHWLJson(jsonText);
  DataSet dataSet = sl<DataSet>();
  Group group = dataSet.groups!.firstWhere((element) => element.name.compareTo(data.first.group) == 0);
  Type type = dataSet.types!.firstWhere((element) => element.name.compareTo(data.first.type) == 0);

  for(var item in data){
    passwords.add(
      Password(
        id: -1, 
        groupId: group.id, 
        typeId: type.id,  
        notes: item.notes, 
        description: item.description,
        email: item.email,
        url: item.url,
        password: item.password,
        passwordValidationId: Validators.mediumPasswordValidator.index,
      )
    );
  }
  for(var password in passwords){
    sl<PasswordBloc>().add(InsertBlindPasswordEvent(password: password));
  }
}