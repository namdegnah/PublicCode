import '../../../domain/entities/group.dart';
import '../../../domain/entities/password.dart';
import '../../../domain/entities/type.dart';
import '../../../data/models/data_set.dart';
import 'package:flutter/material.dart';
import '../../config/style/text_style.dart';
import '../../config/injection_container.dart';
import '../../config/buttons/standard_button.dart';
class PasswordInsertStep extends StatefulWidget {
  const PasswordInsertStep({Key? key, required this.password}) : super(key: key);
  final Password password;
  @override
  State<PasswordInsertStep> createState() => _PasswordInsertStepState();
}

class _PasswordInsertStepState extends State<PasswordInsertStep> {

  Group? selectedGroup;
  Type? selectedType;
  bool enabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Group and Type')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Select Group'),
            const SizedBox(height: 10,),
            getGroupDropdown(),
            const SizedBox(height: 10,),
            const Text('Select Type'),
            getTypeDropdown(),
            const SizedBox(height: 30,),
            getNextStepButton(),
          ],
        ),
      ),
    );
  }
  Widget getNextStepButton(){
    StandardButton sb = StandardButton(
      onTap: () => Navigator.pop(context, widget.password), 
      title: 'Next Step...', 
      enabled: enabled,
      textStyle: buttonText
    );
    return Center(child: sb.button);
  }
  Widget getGroupDropdown(){
    return LimitedBox(
      maxWidth: 90,
      maxHeight: 56,
      child: DropdownButtonFormField<Group>(
        value: null,
        hint: const Text('Select the Group'),
        style: customerData,
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(),
        ),
        items: groupQuantities,
        menuMaxHeight: 300,
        onChanged: (Group? newValue){
          setState(() {
            selectedGroup = newValue!;
            widget.password.groupId = selectedGroup!.id;
            enabled = selectedGroup != null && selectedType != null;
          });
        },        
      ),
    );
  }
  Widget getTypeDropdown(){
    return LimitedBox(
      maxWidth: 90,
      maxHeight: 56,
      child: DropdownButtonFormField<Type>(
        value: null,
        hint: const Text('Select the Type'),
        style: customerData,
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(),
        ),
        items: typesQuantities,
        menuMaxHeight: 300,
        onChanged: (Type? newValue){
          setState(() {
            selectedType = newValue!;
            widget.password.typeId = selectedType!.id;
            enabled = selectedGroup != null && selectedType != null;
          });
        },        
      ),
    );
  }  
}

List<DropdownMenuItem<Group>> get groupQuantities{
  List<Group> groups = sl<DataSet>().groups!;
  return groups.getDropdownValues();
}
List<DropdownMenuItem<Type>> get typesQuantities{
  List<Type> types = sl<DataSet>().types!;
  return types.getDropdownValues();
}