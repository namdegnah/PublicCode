import 'package:flutter/material.dart';
import 'line_paint.dart';

class Animator extends StatefulWidget{

  @override
  _AnimatorState createState() => _AnimatorState();
}

class _AnimatorState extends State<Animator>  with SingleTickerProviderStateMixin {

  double _heightFraction = 0.0;
  
  late Animation<double> heightAnimation;
  late AnimationController controller;

  @override
  void initState() {
    
    controller = AnimationController(duration: const Duration(milliseconds: 7000), vsync: this);
    heightAnimation = Tween(begin: 0.00, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _heightFraction = heightAnimation.value;
        });
      });
    controller.forward();              
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: LinePaint(_heightFraction, null),);
  }  
}