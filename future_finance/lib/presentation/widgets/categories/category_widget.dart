import 'package:flutter/material.dart';
import '../../../domain/entities/category.dart';
import '../../pages/icons_screen.dart';

class CategoryWidget extends StatefulWidget {
  final Category category;
  final GlobalKey<FormState> form;
  final Function saveF;
  CategoryWidget(this.category, this.form, this.saveF);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  var result;
  void _navigateAndDisplayCategoryIcons(BuildContext context) async {
    try{
      result = await Navigator.push(context,MaterialPageRoute(builder: (context) => IconsScreen(catOrRef: true)),);
      if(result != null){
        setState(() {
          widget.category.iconPath = result;
        });
      }
    } catch (error){
      throw Exception('CategoryScreen._navigateAndDisplayCategoryIcons: ' + error.toString());
    }  
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: widget.form,
        child: ListView(
          children: <Widget>[
            // Category Name
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 40,
                decoration: const InputDecoration(hintText: 'Enter the category name', labelText: 'Category Name'),
                initialValue: widget.category.categoryName,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter a valid Category name';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) => widget.category.categoryName = value!,
              ),
            ),
            // Category Description
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                maxLength: 80,
                decoration: const InputDecoration(hintText: 'Enter the category description', labelText: 'Description'),
                initialValue: widget.category.description,
                textInputAction: TextInputAction.none,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Enter some text for the description';
                  } else {
                    return  null;
                  }
                },
                onSaved: (value) => widget.category.description = value!,
              ),              
            ),
            //Icon Image
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(children: <Widget>[
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,                  
                  image: widget.category.iconPath.isEmpty 
                  ? null 
                  : DecorationImage(
                      image: AssetImage(widget.category.iconPath),
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
                    _navigateAndDisplayCategoryIcons(context);
                  }
                ),
              ],),                     
            ),  
            // Use in Finance Facts
            SwitchListTile(
              title: const Text('Use in Finance Facts'),
              value: widget.category.usedForCashFlow,
              subtitle: const Text('Include or Exclude from the Facts run'),
              onChanged: (bool value) {
                setState(() {
                  widget.category.usedForCashFlow = value;
                });
              } 
            ),
          ],
        ),
      ),
    );
  }
}