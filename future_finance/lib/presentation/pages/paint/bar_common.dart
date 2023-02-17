import 'package:flutter/material.dart';

class BarCommon{
  double width;
  double depth;
  Offset start;
  List<String>? verticalTags;  
  List<double>? values;
  BarCommon({
    required this.width, 
    required this.depth,
    required this.start,
    this.verticalTags,
    this.values,
  });
}