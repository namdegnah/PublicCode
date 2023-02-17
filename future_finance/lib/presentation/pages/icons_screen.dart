import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IconsScreen extends StatefulWidget {
  final bool catOrRef;
  IconsScreen({required this.catOrRef});
  static const int catIconNo = 146;
  static const int refIconNo = 87;

  @override
  _IconsScreenState createState() => _IconsScreenState();
}
  void _onTileClicked(BuildContext context, String iconPath){
    Navigator.pop(context, iconPath);
  }

  List<Widget> _getTiles(BuildContext context, List<String> iconList) {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < iconList.length; i++) {
      tiles.add(GridTile(
          child: InkResponse(
        enableFeedback: true,
        child: Image.asset(iconList[i], 
                fit: BoxFit.fitHeight,
                height: 10,        
        ),       
        onTap: () => _onTileClicked(context, iconList[i]),
      )));
    }
    return tiles;
  }
class _IconsScreenState extends State<IconsScreen> {
  
  @override
  Widget build(BuildContext context) {
    var numb = NumberFormat();  
    numb.minimumIntegerDigits = 3;  
    List<String> _images = [];
    if(widget.catOrRef == true){
      for(var i = 1; i <= IconsScreen.catIconNo; i++){
        _images.add('assets/images/category_icons/c${numb.format(i)}.jpg');
      }
    } else {
      for(var i = 1; i <= IconsScreen.refIconNo; i++){
        _images.add('assets/images/recurrence_icons/r${numb.format(i)}.jpg');
      }      
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Icons'),),
      body: GridView.count(
        crossAxisCount: 8,
        padding: const EdgeInsets.all(5),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: _getTiles(context, _images),
      ),      
    );
  }
}