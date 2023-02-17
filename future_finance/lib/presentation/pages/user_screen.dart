import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../presentation/widgets/users/user_widget.dart';

class UserScreen extends StatelessWidget {
  final User user;
  UserScreen({Key? key, required this.user}) : super(key: key);
  final form = GlobalKey<FormState>();
 

  void _saveForm(BuildContext context){
    final isValid = form.currentState!.validate();
    if(!isValid) return;
    form.currentState!.save();    
    Navigator.pop(context, user);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveForm(context),
            ),
        ],
        ),
      body: UserWidget(user, form),
      );
  }
}