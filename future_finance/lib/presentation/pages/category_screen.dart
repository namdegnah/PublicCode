import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../widgets/categories/category_widgets.dart';

class CategoryScreen extends StatelessWidget {
  final Category category;
  CategoryScreen({required this.category});
  final form = GlobalKey<FormState>();

  void _saveForm(BuildContext context){
    final isValid = form.currentState!.validate();
    if(!isValid) return;
    form.currentState!.save();
    Navigator.pop(context, category);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(context),
            ),
        ],
        ),
      body: CategoryWidget(category, form, _saveForm),
    );
  }
}