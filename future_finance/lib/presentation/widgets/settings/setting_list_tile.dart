import 'package:flutter/material.dart';

class SettingListTile extends StatelessWidget {
 
  final Image leadingImage;
  final Function? editSetting;
  final String titleText;

  SettingListTile({required this.leadingImage, required this.editSetting, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        onTap: () => editSetting != null ? editSetting!(context) : null,
        leading: leadingImage,
        title: Text(titleText),
        trailing: Icon(Icons.edit),
      ),
      const Divider(height: 2, thickness: 2,),
    ],);
  }
}