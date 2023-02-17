import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(children: <Widget>[
        DrawerHeader(
          child: Text('Menu'),
          ),
        ListTile(
          title: Text('Option 1'),
        ),
        const Divider(thickness: 1.0,),
        ListTile(
          title: Text('Option 2'),
        ),
      ],),
    );
  }
}