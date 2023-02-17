import 'package:flutter/material.dart';
import '../../../domain/entities/recurrence.dart';
import '../../pages/icons_screen.dart';

class RecurrenceWidget extends StatefulWidget {
  final Recurrence recurrence;
  final GlobalKey<FormState> form;
  final Function saveF;
  RecurrenceWidget(this.recurrence, this.form, this.saveF);

  @override
  _RecurrenceWidgetState createState() => _RecurrenceWidgetState();
}

class _RecurrenceWidgetState extends State<RecurrenceWidget> {
  var chosenType;
  var result;
  var _haveChosenDate = false;
  var _haveChosenOccurrences = false;
  bool _haveChosenIcon = false;

  void showPick(){
      showDatePicker(
        context: context,
        initialDate: widget.recurrence.endDate == null ? DateTime.now() : widget.recurrence.endDate!,
        firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2050), 
      ).then((pickedate){
        setState(() {
          _haveChosenDate = true;
          widget.recurrence.endDate = pickedate;
        });
      });
    }  

  void _navigateAndDisplayRecurrenceIcons(BuildContext context) async {
    try{
      result = await Navigator.push(context,MaterialPageRoute(builder: (context) => IconsScreen(catOrRef: false)),);
      if(result != null){
        setState(() {
          _haveChosenIcon = true;
          widget.recurrence.iconPath = result;
        });
      }
    } catch (error){
      throw Exception('RecurrenceScreen._navigateAndDisplayRecurrenceIcons: ' + error.toString());
    }  
  }
  Widget showTypeSetting(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[    
        Text(widget.recurrence.type == null ? 'No Type chosen' : widget.recurrence.term),
        SizedBox(width: 20),
        PopupMenuButton(
          onSelected: (value) {
            setState(() {
              widget.recurrence.recType = value;
            });           
          }, 
          icon: Icon(Icons.more_vert),
          itemBuilder: (_) => [
            PopupMenuItem(child: Text(widget.recurrence.terms[0]), value: 0,),
            PopupMenuItem(child: Text(widget.recurrence.terms[1]), value: 1,),        
            PopupMenuItem(child: Text(widget.recurrence.terms[2]), value: 2,),
            PopupMenuItem(child: Text(widget.recurrence.terms[3]), value: 3,),         
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _haveChosenDate = widget.recurrence.endDate != null;
    _haveChosenOccurrences = widget.recurrence.noOccurences != null;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: widget.form,
        child: ListView(
          children: <Widget>[
            // Recurence Name
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 40,
                decoration: const InputDecoration(hintText: 'Enter the recurrence name', labelText: 'Recurrence Name'),
                initialValue: widget.recurrence.title,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter a valid Recurrence name';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => widget.recurrence.title = value!,
              ),
            ),
            // Recurence Description
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 80,
                decoration: const InputDecoration(hintText: 'Enter the recurrence description', labelText: 'Description'),
                initialValue: widget.recurrence.description,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter some text for the description';
                  } else {
                    return  null;
                  }
                },
                onSaved: (value) => widget.recurrence.description = value!,
              ),              
            ),
            //Icon Image
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(children: <Widget>[
                Container(
                  width: 180,
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Select the icon for this recurrence', labelText: _haveChosenIcon ? 'Icon Selcted' : 'Select Icon'),
                    readOnly: true,
                    validator: (value){
                      if(widget.recurrence.iconPath.isEmpty){
                        return 'Select an icon for the recurrence';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  image: widget.recurrence.iconPath.isEmpty 
                  ? null 
                  : DecorationImage(
                      image: AssetImage(widget.recurrence.iconPath),
                      fit: BoxFit.fitHeight,
                    ),                          
                  ),
                ),
                TextButton(
                  child: const Text(
                    'Icon Select',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _navigateAndDisplayRecurrenceIcons(context);
                  }
                ),
              ],),                     
            ),  
            // Type
            showTypeSetting(),
            // OPTIONS
            Card(
              color: Colors.blueGrey[50], 
              child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top:10),
                  child: Text('Options', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                // No Occurences for Recurrence (disables End Date)
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    maxLength: 10,
                    enabled: !_haveChosenDate,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                    onChanged: (text){
                      setState(() {
                        _haveChosenOccurrences = (null != int.tryParse(text) && 0 != int.parse(text));
                      });
                    },
                    decoration: InputDecoration(hintText: 'Number of Occurrences', labelText: 'Number of Recurrences'),
                    initialValue: widget.recurrence.noOccurences == null ? 0.toString() : widget.recurrence.noOccurences.toString(),
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (_) => widget.saveF(),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please enter the number of occurrences';
                      }
                      if(null == int.tryParse(value)){
                        return 'please enter a valid whole number for the number of occurences';
                      }
                      if(int.parse(value) < 0){
                        return 'please enter a zero or positive whole number for the number of occurences';
                      }
                      return null;
                    },
                    onSaved: (value) => widget.recurrence.noOccurences = int.parse(value!),
                  ),
                ),
                // End Date for Recurrence (disables No Occurences)
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Row(children: <Widget>[
                    widget.recurrence.showDateSetting(),
                    TextButton(
                      child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: _haveChosenOccurrences ? null : showPick,
                    ),
                  ],),
                ),                
              ],),
            ),
          ],
        ),
      ),
    );
  }
}