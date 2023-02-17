import 'package:flutter/material.dart';

extension x1 on Text {
  buff({required double pad}){
    return Text(
      this.data!,
      style: TextStyle(
        fontSize: 16, 
        fontWeight: FontWeight.bold, 
        color: Colors.red,
      ),
    ).addContainer(pad);
  }
}
extension polishName on Text {
  polish({required double pad, required double size}){
    return Text(
      this.data!,
      style: TextStyle(
        color: Colors.black, 
        fontSize: size, 
        fontWeight: FontWeight.normal, 
        shadows: [
          Shadow(color: Colors.black26, 
                offset: Offset(1.0, 1.0), 
                blurRadius: 1.0
          )
        ]
      ),
    ).addContainer(pad);
  }
}
extension contName on Widget {
  addContainer(double pad){
    return Container(      
      padding: EdgeInsets.all(pad),
      margin: EdgeInsets.all(pad),
      child: this,
    );
  }
}
extension wlf on Widget {
  Widget paddLR(double padding) => 
    Padding (padding: EdgeInsets.only(left: padding, right: padding), 
    child: this,
  );        
}
extension wall on Widget {
  Widget paddAll(double padding) => 
    Padding (padding: EdgeInsets.all(padding), 
    child: this
  );        
}