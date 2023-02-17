import 'package:flutter/material.dart';
import '../../core/util/form_elements.dart';
import '../config/style/text_style.dart';
import '../../core/util/validation.dart';
import '../config/style/text_input_decorations.dart';
import '../../domain/entities/password_field.dart';

class FormHomeScreen extends StatefulWidget {
  const FormHomeScreen({super.key});

  @override
  State<FormHomeScreen> createState() => _FormHomeScreenState();
}

class _FormHomeScreenState extends State<FormHomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FocusNode _urlNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  String url = '';
  String? password;
  PasswordField pf = PasswordField(id: 1, name: 'Abc', description: '', hintText: 'Type ABC', errorText: 'You must enter text', validationIndex: 1, length: 5);
  PasswordField pf2 = PasswordField(id: 2, name: 'Email', description: '', hintText: 'type email', errorText: 'Email must be valid', validationIndex: 2, length: 5);
  
  void _saveForm(BuildContext context){
    final isValid = _formKey.currentState!.validate();
    if(!isValid) return;
    _formKey.currentState!.save(); 
    url = pf.fieldvalue!;
    password = pf2.fieldvalue!;
    print('url is $url and password is $password');   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Testing'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveForm(context),
            ),
        ],        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // url
              pf.getTextFormField(
                context: context, 
                thisNode: _urlNode, 
                nextNode: _passwordNode, 
              ),
              SizedBox(height: 10,),
              // password 
              pf2.getTextFormField(
                context: context, 
                thisNode: _passwordNode, 
              ),                            
              SizedBox(height: 5,),
              // follows
              SizedBox(height: 50,),
              Text('I\'m down below', style: customerData,),
            ],
          ),
        ),  
      ),

    );
  }
}