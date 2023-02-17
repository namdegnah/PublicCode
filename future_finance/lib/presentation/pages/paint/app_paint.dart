import 'package:flutter/material.dart';

class AppPaint extends CustomPainter {
  
  late Paint _paint;
  AppPaint(){
    _paint = Paint()
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 2.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double a = 10.0;
    double b = 50.0;
    double gap = 1.0;
    double c = a - gap;
    double d = b + gap;
    _paint.color = const Color(0xff942313);
    _paint.strokeWidth = 2.5;
    _paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(a, a);
    path.lineTo(a, b);
    path.lineTo(b, b);
    path.lineTo(b, a);
    // path.lineTo(10, 10);
    canvas.drawPath(path, _paint); 
    _paint.color = const Color(0xff000000);
    _paint.strokeWidth = 1;
     _paint.style = PaintingStyle.stroke;
    path.moveTo(c,c);
    path.lineTo(a,d);
    path.lineTo(d, b);
    path.lineTo(d, c); 
    path.lineTo(c, c);  
    canvas.drawPath(path, _paint);     
  }
  @override
  bool shouldRepaint(AppPaint oldDelegate) {
    return false;
  }    
}