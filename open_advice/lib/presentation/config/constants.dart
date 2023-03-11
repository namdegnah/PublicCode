import 'package:flutter/material.dart';

class Currencies{
  static final _values = ['\u0024', '\u00A3', '\u00A5', '\u20AC'];
  static final _terms = ['Dollar', 'Pound', 'Yen', 'Euro'];
  static String currencyTerm(int currency) => _terms[currency];
  static String currencyValue(int currency) => _values[currency];
  static List<PopupMenuItem> getCurrencyItems(){
    return [
        PopupMenuItem(child: Text(_terms[0]), value: 0,),
        PopupMenuItem(child: Text(_terms[1]), value: 1,),        
        PopupMenuItem(child: Text(_terms[2]), value: 2,),
        PopupMenuItem(child: Text(_terms[3]), value: 3,),      
    ];
  }  
}