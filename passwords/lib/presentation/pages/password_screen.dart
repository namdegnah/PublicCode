import 'package:flutter/material.dart';
import '../../domain/entities/password.dart';
import '../widgets/password/password_widget.dart';
import '../config/injection_container.dart';
import '../../../data/models/data_set.dart';
import '../../../domain/entities/type.dart';
import 'package:passwords/domain/entities/password_field.dart';
import '../config/style/app_colours.dart';

class PasswordScreen extends StatefulWidget {
  final Password password;
  PasswordScreen({Key? key, required this.password}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final form = GlobalKey<FormState>();

  void _saveForm(BuildContext context){
    if(widget.password.isValidated!){
      final isValid = form.currentState!.validate();
      if(!isValid) return;  
    }
    form.currentState!.save();
    final Type type = sl<DataSet>().types!.firstWhere((element) => element.id == widget.password.typeId,);
    final List<PasswordField> fields = type.fieldList!;
    for(var field in fields){
      widget.password.updatePassword(field);
    }    
    Navigator.pop(context, widget.password);
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
          Checkbox(
            checkColor: simplyBlack,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: widget.password.isValidated ?? true,
            onChanged: (bool? value){
            setState(() {
              widget.password.isValidated = value;
            });
              
            },
          ),
        ],
        ),
      body: PasswordWidget(widget.password, form),
      );
  }
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.white;
  }  
}