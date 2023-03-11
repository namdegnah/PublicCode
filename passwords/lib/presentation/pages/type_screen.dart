import 'package:flutter/material.dart';
import '../../domain/entities/type.dart';
import '../widgets/type/type_widget.dart';

class TypeScreen extends StatelessWidget {
  final Type type;
  TypeScreen({Key? key, required this.type}) : super(key: key);
  final form = GlobalKey<FormState>();
 

  void _saveForm(BuildContext context){
    final isValid = form.currentState!.validate();
    if(!isValid) return;
    form.currentState!.save();    
    Navigator.pop(context, type);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Type Item'),
        actions: <Widget>[
          IconButton(
            key: const Key('typeSaveButton'),
            icon: const Icon(Icons.save),
            onPressed: () => _saveForm(context),
            ),
        ],
        ),
      body: TypeWidget(type, form),
      );
  }
}