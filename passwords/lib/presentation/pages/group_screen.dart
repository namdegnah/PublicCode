import 'package:flutter/material.dart';
import '../../domain/entities/group.dart';
import '../widgets/group/group_widget.dart';

class GroupScreen extends StatelessWidget {
  final Group group;
  GroupScreen({Key? key, required this.group}) : super(key: key);
  final form = GlobalKey<FormState>();
 

  void _saveForm(BuildContext context){
    final isValid = form.currentState!.validate();
    if(!isValid) return;
    form.currentState!.save();    
    Navigator.pop(context, group);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Group'),
        actions: <Widget>[
          IconButton(
            key: ValueKey('groupSaveButton'),
            icon: const Icon(Icons.save),
            onPressed: () => _saveForm(context),
            ),
        ],
        ),
      body: GroupWidget(group, form),
      );
  }
}