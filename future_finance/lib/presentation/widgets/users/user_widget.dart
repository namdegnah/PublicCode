import 'package:flutter/material.dart';
import '../../../domain/entities/user.dart';


class UserWidget extends StatefulWidget {
  @required final User user;
  @required final GlobalKey<FormState> form;

  const UserWidget(this.user, this.form, {Key? key}) : super(key: key);

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {

  @override
  Widget build(BuildContext context) {

    String passwordEnter = '';
    String passwordCheck = '';    
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: widget.form,
        child: ListView(
          children: <Widget>[
            //User Name
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 40,
                decoration: const InputDecoration(hintText: 'Enter the User name', labelText: 'User Name'),                
                initialValue: widget.user.name,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter a valid User name';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => widget.user.name = value!,
              ),
            ),
            // User Password
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 80,
                decoration: const InputDecoration(hintText: 'Enter the User password', labelText: 'Password'),
                initialValue: widget.user.password,
                obscureText: true,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter a password for the User';
                  } else {
                    passwordEnter = value;
                    return  null;
                  }
                },
                onSaved: (value) => widget.user.password = value!,
              ),              
            ),
            // Check Password
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 80,
                decoration: const InputDecoration(hintText: 'Enter the User password again', labelText: 'Password'),
                initialValue: passwordCheck,
                obscureText: true,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value != passwordEnter){
                    return 'Passwords do not match, try again';
                  } else {
                    return  null;
                  }
                },
                onSaved: (value) => passwordCheck = value!,
              ),              
            ),            
            // User Email
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 80,
                decoration: const InputDecoration(hintText: 'Enter the user email', labelText: 'Email'),
                initialValue: widget.user.email,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter an email for the user';
                  } else {
                    return  null;
                  }
                },
                onSaved: (value) => widget.user.email = value!,
              ),              
            ),            
            // Change to default button
          ],
        ),
      ),
    );
  }
}