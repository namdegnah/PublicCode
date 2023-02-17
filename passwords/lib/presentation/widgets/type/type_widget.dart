import 'package:flutter/material.dart';
import '../../../domain/entities/type.dart';

class TypeWidget extends StatefulWidget {
  final Type type;
  final GlobalKey<FormState> form;
  const TypeWidget(this.type, this.form, {Key? key}) : super(key: key);

  @override
  _TypeWidgetState createState() => _TypeWidgetState();
}

class _TypeWidgetState extends State<TypeWidget> {

  late TextEditingController _dueDateController = TextEditingController();
  late DateTime dueDateUsed;

  @override
  void dispose() {
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: widget.form,
        child: ListView(
          children: <Widget>[
            //Type name
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 40,
                decoration: const InputDecoration(hintText: 'Enter the Type name', labelText: 'Type name'),                
                initialValue: widget.type.name,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter a valid Type name';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => widget.type.name = value!,
              ),
            ),                        
          ],
        ),
      ),
    );
  } 
}