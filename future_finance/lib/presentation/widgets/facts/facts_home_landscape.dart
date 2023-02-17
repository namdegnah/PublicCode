import 'package:flutter/material.dart';
import '../../pages/paint/excel_animator.dart';
import '../../../data/models/facts_base.dart';
import '../../pages/paint/scaler.dart';

class FactsHomeLandscape extends StatelessWidget {
  final FactsBase factsbase;  
  FactsHomeLandscape({required this.factsbase});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExcelAnimator(factsbase: factsbase),
      alignment: Alignment.topLeft,
    );
  }
}