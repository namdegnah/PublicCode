import 'package:flutter/material.dart';

class BarDetails{
  final String name;
  final int x;
  final int y; 
  final int size5;
  final int size4;
  final int width;
  final int depth;
  final int portraitGap;
  BarDetails({required this.name, required this.y, required this.x, required this.size5, required this.size4, required this.depth, required this.width, required this.portraitGap});
  
}
List<BarDetails> getBarDetails(){
  List<BarDetails> ans = [];
  ans.add(BarDetails(name: 'Small Portrait', x: 90, y: 240, size5: 200, size4: 160, width: 30, depth: 20, portraitGap: 300));
  ans.add(BarDetails(name: 'Small Landscape', x: 90, y: 240, size5: 200, size4: 160, width: 20, depth: 15, portraitGap: 300));
  ans.add(BarDetails(name: 'Medium Portrait', x: 100, y: 280, size5: 250, size4: 200, width: 20, depth: 15, portraitGap: 300));
  ans.add(BarDetails(name: 'Medium Landscape', x: 110, y: 240, size5: 200, size4: 160, width: 25, depth: 15, portraitGap: 300));
  ans.add(BarDetails(name: 'Large Portrait', x: 110, y: 450, size5: 400, size4: 320, width: 50, depth: 30, portraitGap: 500));
  ans.add(BarDetails(name: 'Large Landscape', x: 110, y: 420, size5: 400, size4: 320, width: 35, depth: 15, portraitGap: 300));
  return ans;
}  