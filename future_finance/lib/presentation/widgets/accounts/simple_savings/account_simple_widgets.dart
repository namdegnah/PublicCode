import '../../../../domain/entities/accounts/account_add_interest.dart';
import 'package:flutter/material.dart';
import '../../../../domain/entities/recurrence.dart';
import '../../../widgets/common_widgets.dart';
    
  Future<int> showRecurrenceDialog(BuildContext context, List<Recurrence> recurrences) async {   
      return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Recurrences'), // Could this be central? Why is it bold and bigger? Colour maybe
        children: _convertRecurrences(context,recurrences),
        contentPadding: EdgeInsets.all(15),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0,),
          side: BorderSide(width: 2.0, color: Colors.grey),
        ),
      ), 
    ); 
  }  
  // Recurrence Dialog
  List<Widget> _convertRecurrences(BuildContext context, List<Recurrence> recurrences){ 
    List<Widget> lsdo = [];
    for(Recurrence recurrence in recurrences){
      lsdo.add(Row(children: <Widget>[
        SizedBox(width: 5,),
        IconListImage(recurrence.iconPath, 25),
        SizedBox(width: 3,),
        SimpleDialogOption(child: Text(recurrence.title), onPressed: () => Navigator.pop(context, recurrence.id)),                
      ],));
      lsdo.add(Divider(thickness: 1,));      
    }
    lsdo.removeLast();
    return lsdo;
  }
//=======================================================================================================================  
  Future<int> showAddInterestDialog(BuildContext context, List<AddInterest> addInterests) async {   
      return await showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Add Interest When?'),
        children: _convertAddInterest(context, addInterests),
        contentPadding: EdgeInsets.all(15),
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0,),
          side: BorderSide(width: 2.0, color: Colors.grey),
        ),
      ), 
    ); 
  }  
  // Recurrence Dialog
  List<Widget> _convertAddInterest(BuildContext context, List<AddInterest> addInterests){ 
    List<Widget> lsdo = [];
    for(AddInterest addInterest in addInterests){
      lsdo.add(Row(children: <Widget>[
        SizedBox(width: 5,),
        IconListImage(addInterest.iconPath, 25),
        SizedBox(width: 3,),
        SimpleDialogOption(child: Text(addInterest.title), onPressed: () => Navigator.pop(context, addInterest.id)),                
      ],));
      lsdo.add(Divider(thickness: 1,));      
    }
    lsdo.removeLast();
    return lsdo;
  }
//=======================================================================================================================    
  
   