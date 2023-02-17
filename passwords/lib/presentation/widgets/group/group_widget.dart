import 'package:flutter/material.dart';
import '../../../domain/entities/group.dart';

class GroupWidget extends StatefulWidget {
  final Group group;
  final GlobalKey<FormState> form;
  //final Function saveF;
  const GroupWidget(this.group, this.form, {Key? key}) : super(key: key);

  @override
  _GroupWidgetState createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {

  @override
  Widget build(BuildContext context) {
    
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
                decoration: const InputDecoration(hintText: 'Enter the Group name', labelText: 'Group Name'),                
                initialValue: widget.group.name,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter a valid Group name';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => widget.group.name = value!,
              ),
            ),            
            // Change to default button
          ],
        ),
      ),
    );
  }
}