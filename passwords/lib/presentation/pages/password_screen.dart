import 'package:flutter/material.dart';
import '../../domain/entities/password.dart';
import '../widgets/password/password_widget.dart';
import '../config/injection_container.dart';
import '../../../data/models/data_set.dart';
import '../../../domain/entities/type.dart';
import 'package:passwords/domain/entities/password_field.dart';

class PasswordScreen extends StatelessWidget {
  final Password password;
  PasswordScreen({Key? key, required this.password}) : super(key: key);
  final form = GlobalKey<FormState>();
 

  void _saveForm(BuildContext context){
    final isValid = form.currentState!.validate();
    if(!isValid) return;
    form.currentState!.save();
    final Type type = sl<DataSet>().types!.firstWhere((element) => element.id == password.typeId,);
    final List<PasswordField> fields = type.fieldList!;
    for(var field in fields){
      password.updatePassword(field);
    }  
    Navigator.pop(context, password);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Password'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveForm(context),
            ),
        ],
        ),
      body: PasswordWidget(password, form),
      );
  }
}