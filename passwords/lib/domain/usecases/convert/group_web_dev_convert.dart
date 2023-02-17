import '../../entities/temp_convert/group_dev_weblogin.dart';
import 'package:flutter/services.dart';
import '../../entities/password.dart';
import '../../entities/group.dart';
import '../../entities/type.dart';
import '../../../presentation/config/injection_container.dart';
import '../../../data/models/data_set.dart';
import '../../../presentation/bloc/password/password_bloc.dart';
import '../../../presentation/bloc/password/password_bloc_events.dart';

Future<void> convertDevWebLogin() async {

  List<Password> passwords = [];
  var jsonText = await rootBundle.loadString('assets/json/groupdevweb.json');
  List<GroupDevWebLogin> data = modelGDWFromJson(jsonText);
  DataSet dataSet = sl<DataSet>();
  Group group = dataSet.groups!.firstWhere((element) => element.name.compareTo(data.first.group) == 0);
  Type type = dataSet.types!.firstWhere((element) => element.name.compareTo(data.first.type) == 0);

  for(var gdwl in data){
    passwords.add(
      Password(
        id: -1, 
        groupId: group.id, 
        typeId: type.id, 
        password: gdwl.password, 
        notes: gdwl.notes, 
        description: gdwl.description,
        url: gdwl.url,
        email: gdwl.email,
      )
    );
  }
  for(var password in passwords){
    sl<PasswordBloc>().add(InsertBlindPasswordEvent(password: password));
  }
}