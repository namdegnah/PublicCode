import 'package:flutter/material.dart';
import 'bar_loader.dart';
import 'scaler.dart';
import 'dart:math';

class LinePaint extends CustomPainter{

  late double _heightFraction;  
  late Paint _paint;
  late List<BarLoader>? loaders;
  final double gap = 5;
  final double gapPlus = 10;
  final double backgroundDepth = 1;
  final int scaleMax5 = Scaler.barDetails!.size5;
  final int scaleMax4 = Scaler.barDetails!.size4;
  late Offset a, b, c, d, e, f, g, h, i, j, k;
  TextPainter tp = TextPainter();
  final gradientP = const LinearGradient(colors: [const Color(0xffE0BD25), const Color(0xffEDD05C)], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  final topP = const Color(0xffB29D46);
  final sideP = const Color(0xff988327);
  final gradientN= const LinearGradient(colors: [const Color(0xff942313), const Color(0xffDF422B)], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  final topN = const Color(0xffAC3322);
  final sideN = const Color(0xff752014);  
  final colorBlack = const Color(0xFF000000);
  final textBlack = const TextStyle(color: const Color(0xFF000000));
  late Offset start;

  LinePaint(this._heightFraction, this.loaders){
    _paint = Paint()
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 1.0;
    
  }
  @override
  void paint(Canvas canvas, Size size) {
    start = Offset(Scaler.barDetails!.x.ceilToDouble(), Scaler.barDetails!.y.ceilToDouble());
    double dxS, dyS;
    scaleLoaders(loaders: loaders!);
    processBackground(canvas: canvas, loaders: loaders!, noLoaders: loaders!.length);
    for(var loader in loaders!){
      processPoints(loader: loader,  hf: _heightFraction);
      start = Offset(start.dx + Scaler.barDetails!.width +  Scaler.barDetails!.depth * cos(Scaler.gamma) + gap, start.dy); 
      print(start.dx.toString() + ' : ' +  start.dy.toString());
    }    
    double aTemp = 10.0;
    double bTemp = 50.0;
    _paint.color = const Color(0xff000000);
    _paint.strokeWidth = 15;
     _paint.style = PaintingStyle.stroke;
    var path = Path();
    path.moveTo(aTemp,bTemp);
    path.lineTo(aTemp, bTemp - (bTemp * _heightFraction)); 
    canvas.drawPath(path, _paint);     
  }
  void processBackground({required Canvas canvas, required List<BarLoader> loaders, required int noLoaders}){
    processPoints(loader: loaders[0], hf: 1.0);
    var lm = (d.dy - g.dy)/(d.dx - g.dx);
    var lc = d.dy - lm * d.dx;
    var hx = d.dx + 3*(g.dx - d.dx)/2;
    var hy = lm * hx + lc;
    h = Offset(hx + (noLoaders - 1) * (gap + Scaler.barDetails!.depth +  Scaler.barDetails!.width * cos(Scaler.beta)), hy);
    i = Offset(a.dx - gapPlus, h.dy);
    lc = i.dy - lm * i.dx;
    var lb = backgroundDepth * Scaler.barDetails!.depth / sqrt(pow(lm, 2) + 1);
    var jx = i.dx - lb;
    var jy = lm * jx + lc;
    j = Offset(jx, jy);
    k = Offset(h.dx - i.dx + j.dx, j.dy);
    _paint.color = const Color(0xff000000);
    _paint.strokeWidth = 0.5;
    _paint.style = PaintingStyle.stroke;
    var path = Path();
    path.moveTo(j.dx, j.dy);
    path.lineTo(i.dx, i.dy);
    path.lineTo(h.dx, h.dy);
    canvas.drawPath(path, _paint);
    TextSpan zero = TextSpan(
      style: TextStyle(color: const Color(0xff000000),),
      text: '0'
      );
    tp.text = zero;
    tp.textAlign = TextAlign.left;
    tp.textDirection = TextDirection.ltr;
    tp.layout();
    tp.paint(canvas, Offset(j.dx - gapPlus - 7, j.dy - gapPlus));
    // now print the vertical lines and tags, vertical tags in common
    var sg = Scaler.verticalTags.length == 4 ? scaleMax4 / 4 : scaleMax5 / 5;
    Offset m = j, l = i, n = h;
    for(var tag in Scaler.verticalTags){
      m = Offset(m.dx, m.dy - sg);
      l = Offset(l.dx, l.dy - sg);
      n = Offset(n.dx, n.dy - sg);
      path.reset();
      path.moveTo(m.dx, m.dy);
      path.lineTo(l.dx, l.dy);
      path.lineTo(n.dx, n.dy);
      canvas.drawPath(path, _paint);
      zero = TextSpan(text: '£' + tag, style: TextStyle(color: const Color(0xff000000)));
      tp.text = zero;
      tp.layout();
      tp.paint(canvas, Offset(m.dx - gapPlus - tag.length * 10, m.dy - gapPlus));
    }
  }
  void processPoints({required BarLoader loader, required double hf}){
    a = start;
    b = Offset(a.dx, a.dy - loader.value * hf);
    c = Offset(b.dx + Scaler.barDetails!.width * cos(Scaler.beta), b.dy + Scaler.barDetails!.width * sin(Scaler.beta));
    d = Offset(c.dx, c.dy + loader.value * hf);
    e = Offset(b.dx + Scaler.barDetails!.depth * cos(Scaler.gamma), b.dy - Scaler.barDetails!.depth * sin(Scaler.gamma));
    g = Offset(d.dx + Scaler.barDetails!.depth * cos(Scaler.gamma), d.dy - Scaler.barDetails!.depth * sin(Scaler.gamma));
    f = Offset(g.dx, g.dy - loader.value * hf);
  }    
  void scaleLoaders({required List<BarLoader> loaders}){
    
    double maxValue = 0.0;
    for(var loader in loaders){
      if(loader.height.abs() > maxValue) maxValue = loader.height.abs();
    }
    var maxValueInt = maxValue.ceil();
    int digits = numberPower(maxValueInt);
    if(digits == 0) digits = 1;
    if (digits == 2){
      Scaler.twoDigits(loaders: loaders, scaleMax4: scaleMax4, scaleMax5: scaleMax5, value: maxValueInt, power: 1, extras: '');
    } else if (digits == 1){
      Scaler.oneDigit(loaders: loaders, scaleMax4: scaleMax4, scaleMax5: scaleMax5, value: maxValueInt);
    } else {
      Scaler.moreDigits(loaders: loaders, digits: digits, scaleMax4: scaleMax4, scaleMax5: scaleMax5, value: maxValueInt);
    }
  }
  int numberPower(int data){
    int a = 0;
    
    while(data != 0){
      data = (data/10).floor();
      ++a;
    }
    return a;
  }  
  @override
  bool shouldRepaint(LinePaint oldDelegate) {
    return oldDelegate._heightFraction != _heightFraction;
  }      
}