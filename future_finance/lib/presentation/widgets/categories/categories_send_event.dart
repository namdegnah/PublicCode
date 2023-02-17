import 'package:flutter/material.dart';
import '../../bloc/categories/categories_bloc_exports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesSendEvent extends StatelessWidget {
  CategoriesSendEvent();
  
  @override
  Widget build(BuildContext context) {
    
    BlocProvider.of<CategoriesBloc>(context).add(GetCategoriesEvent());  
    return const SizedBox(height: 1);      
  }

}