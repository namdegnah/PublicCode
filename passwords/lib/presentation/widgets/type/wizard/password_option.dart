import '../../../../domain/entities/type.dart';
import 'package:flutter/material.dart';
class PasswordOption extends StatefulWidget {
  const PasswordOption({required this.type, super.key});
  final Type type;
  @override
  State<PasswordOption> createState() => _PasswordOptionState();
}

class _PasswordOptionState extends State<PasswordOption> {

  late String radioSelected;

  String setRadioSelected(Type type){
    if(type.passwordValidationId == null) return 'Strong';
    if(type.passwordValidationId == 4) return 'Medium';
    if(type.passwordValidationId == 5) return 'Weak';
    return 'Strong';
  }
  @override
  Widget build(BuildContext context) {
    radioSelected = setRadioSelected(widget.type);
    return Column(
      children: <Widget>[
        SizedBox(
          height: 80,
          child: RadioListTile(
            key: const Key('passwordStrongType'),
            title: const Text("Strong"),
            subtitle: const Text("between 8 to 16 characters, contain at least one number, one upper character, one lower case character and a special character."),
            value: "Strong", 
            groupValue: radioSelected, 
            onChanged: (value){
              setState(() {
                  radioSelected = value.toString();
                  widget.type.passwordValidationId = 3;
              });
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: RadioListTile(
            key: const Key('passwordMediumType'),
            title: const Text("Medium"),
            subtitle: const Text("between 6 to 16 characters, contain at least one number, one upper character, one lower case character."),             
            value: "Medium", 
            groupValue: radioSelected, 
            onChanged: (value){
              setState(() {
                  radioSelected = value.toString();
                  widget.type.passwordValidationId = 4;
              });
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: RadioListTile(
            key: const Key('passwordWeakType'),
            title: const Text("Weak"),
            subtitle: const Text("between 6 to 16 characters."),             
            value: "Weak", 
            groupValue: radioSelected, 
            onChanged: (value){
              setState(() {
                  radioSelected = value.toString();
                  widget.type.passwordValidationId = 5;
              });
            },
          ),
        ),                     
      ],           
    );
  }
}