import 'package:flutter/material.dart';
import '../../widgets/common_widgets.dart';
import '../../config/style/app_colours.dart';
import '../../config/style/text_style.dart';
import 'dart:math';

// ignore: must_be_immutable
class FastAnimation extends StatefulWidget implements CanSize {
  FastAnimation({ Key? key }) : super(key: key);

  @override
  State<FastAnimation> createState() => _FastAnimationState();
  // ignore: unused_field
  late bool _size;
  @override
  set size(bool size) => _size = size;
}

class _FastAnimationState extends State<FastAnimation> with TickerProviderStateMixin {

  double _numberFraction = 0.0;
  double _singleTimeFraction = 0.0;
  final Duration _duration = const Duration(seconds: 2);
  late AnimationController controller = AnimationController(duration: _duration, vsync: this);
  late AnimationController opacityController = AnimationController(duration: _duration, vsync: this);
  late Animation<double> numberAnimation;
  late Animation<double> singleAnimation;

  @override
  void initState() {
    numberAnimation = Tween(begin: 0.00, end: 1.0).animate(opacityController)
      ..addListener(() {
        setState(() {
          _numberFraction = numberAnimation.value;
        });
      });
    singleAnimation = Tween(begin: 0.00, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _singleTimeFraction = singleAnimation.value;
        });
      });    
    controller.forward();  
    opacityController.forward();
    opacityController.repeat(reverse: true);          
    super.initState();
  }
  @override
  void dispose() {
    opacityController.dispose();
    controller.dispose();
    super.dispose();
  }  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const double cnw = 400;
    const double cmw = 800;
    const double fns = 12;
    const double fms = 15;

    double getFontSize(double width){
      return max(fns + (fms -fns) * (width - cnw)/(cmw - cnw), fns);
    }         
    return SizedBox(
      height: 450,
      width: 800,
      child: Stack(
        children: <Widget>[
          Container(
            height: 400,
            width: 850, // This must reduce as the width reduces
            decoration: BoxDecoration(
              color: textFast.withOpacity(0.05 + _numberFraction * 0.125),
            ),
          ),
          if(widget._size) Positioned(
            top: 400 - _singleTimeFraction * 400,
            left: -50,
            child: Transform.scale(
              scale: 0.35 + (_singleTimeFraction * 0.35),
              child: Transform.rotate(
                angle: (90 - _singleTimeFraction * 90)/360,
                child: const Image(image: AssetImage('assets/images/code_01.png'),),
              ),
            ),
          ),
          Positioned(
            top: 200 + (400 - _singleTimeFraction * 400),
            //left: widget._size ? 430 : 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fast, Robust, Complient', style: anyStyle(start: dashboardHi20, color: textFast, fontSize: 20, fontWeight: FontWeight.w700),),
                const SizedBox(height: 10,),
                // This is one text that wraps and the font size reduces
                Container(
                  width: isMobileScreen(context) ? 160 : 280,
                  height: 600,
                  color: Colors.transparent,
                  child: anyText(text: 'My code is designed to run fast from the start, it is robust and complient with the design', style: anyStyle(start: dashboardHi20, fontSize: getFontSize(width), fontWeight: FontWeight.w400)),
                ),   
              ],
            ),
          ),          
        ],
      ),
    );
  }
}