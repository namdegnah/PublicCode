import 'package:flutter/material.dart';
import 'button_group.dart';
import '../../../../domain/entities/type.dart';
import '../../../../domain/entities/password_field.dart';
import '../../../config/style/text_style.dart';
import 'password_option.dart';

class TypeWizzard extends StatefulWidget {
  const TypeWizzard({Key? key, required this.type, required this.fields}) : super(key: key);
  
  final Type type;
  final List<PasswordField> fields;
  
  @override
  State<TypeWizzard> createState() => _TypeWizzardState();
}

class _TypeWizzardState extends State<TypeWizzard> {
  int stepNo = 0;

  @override
  Widget build(BuildContext context) {
  
  var bg =  ButtonGroup(
      addEnabled: widget.fields[stepNo].addEnabled,
      addOnTapped: () => setState(() {
        widget.type.addField(widget.fields[stepNo].id);
        widget.fields[stepNo].removeEnabled = true;
      }),
      removeEnabled: widget.fields[stepNo].removeEnabled,
      removeOnTapped: () => setState((){
        widget.type.removeField(widget.fields[stepNo].id);
      }),
      nextEnabled: widget.fields[stepNo].nextEnabled,
      nextOnTapped: () => setState(() {
        stepNo++;
      }),
      previousEnabled: widget.fields[stepNo].previousEnabled,
      previousOnTapped: () => setState(() {
        stepNo--;
      }),
      width: 150,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Type Wizzard'),
        actions: [
          IconButton(
            icon: stepNo == widget.fields.length - 1 ? const Icon(Icons.save) : const Icon(Icons.save, color: Colors.black12),
            onPressed: () => stepNo == widget.fields.length - 1 ? Navigator.pop(context, widget.type) : null,
            ),          
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Step ${stepNo + 1} of ${widget.fields.length}', style: wizardStep,),
              const SizedBox(height: 10,),
              Text('Field Name: ${widget.fields[stepNo].name}', style: wizardName,),
              const SizedBox(height: 10,),
              Text(widget.fields[stepNo].description, style: wizardDescription,),
              const SizedBox(height: 10,),
              if(widget.fields[stepNo].widgetId != null && widget.fields[stepNo].widgetId == 1) PasswordOption(type: widget.type),
              const SizedBox(height: 30,),
              bg.buttonGroup,
              const SizedBox(height: 10,),
              
            ],
          ),
        ),
      ),
    );
  }  
}

