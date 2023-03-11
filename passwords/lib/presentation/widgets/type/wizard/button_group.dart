import 'package:flutter/material.dart';
import '../../../config/buttons/standard_button.dart';

class ButtonGroup{

  ButtonGroup({
    this.addOnTapped,
    this.removeOnTapped,
    this.nextOnTapped,
    this.previousOnTapped,
    this.addEnabled,
    this.removeEnabled,
    this.nextEnabled,
    this.previousEnabled,
    this.height,
    this.width,
    this.textColor,
    this.textStyle,
    this.cornerRadius,
  });

  final Function()? addOnTapped;
  final Function()? removeOnTapped;
  final Function()? nextOnTapped;
  final Function()? previousOnTapped;
  bool? addEnabled;
  bool? removeEnabled;
  bool? previousEnabled;
  bool? nextEnabled;
  final double? height;
  final double? width;
  final Color? textColor;
  final TextStyle? textStyle;
  final double? cornerRadius;

  Widget get buttonGroup {

    StandardButton add = StandardButton(
      onTap: addOnTapped, 
      title: 'Add', 
      enabled: addEnabled ?? false,
      width: width,
      key: 'typeWizardAddButton'
    );
    StandardButton remove = StandardButton(
      onTap: removeOnTapped, 
      title: 'Remove', 
      enabled: removeEnabled ?? false,
      width: width,
      key: 'typeWizardRemoveButton'
    );    
    StandardButton next = StandardButton(
      onTap: nextOnTapped, 
      title: 'Next', 
      enabled: nextEnabled ?? false,
      width: width,
      key: 'typeWizardNextButton'
    );
    StandardButton previous = StandardButton(
      onTap: previousOnTapped, 
      title: 'Previous', 
      enabled: previousEnabled ?? false,
      width: width,
      key: 'typeWizzardPreviousButton'
    );    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        add.button,
        const SizedBox(height: 10,),
        remove.button,
        const SizedBox(height: 10,),
        Row(
          children: <Widget>[
            const Spacer(flex: 1,),
            previous.button,
            const Spacer(flex: 2,),
            next.button,
            const Spacer(flex: 1),
          ],
        ),
      ],
    );
  }  
}