import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/category.dart';
import '../../config/injection_container.dart';
import '../../bloc/categories/categories_bloc_exports.dart';
import '../../pages/category_screen.dart';
import '../common_widgets.dart';

class CategoryListTile extends StatelessWidget {
  final Category category;
  CategoryListTile(this.category);
  late int id;

  void _deleteCategory(BuildContext context, int id) {

    BlocProvider.of<CategoriesBloc>(context).add(DeleteCategoryEvent(id: id));  
  }

  void _navigateAndDisplayCategory(BuildContext context, int id) async {

    var result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => 
      BlocProvider.value(
        value: sl<CategoriesBloc>(),
        child: CategoryScreen(category: category), 
      ),
    ));
    if(result != null){
      CategoriesBloc cb = BlocProvider.of<CategoriesBloc>(context);
      cb.add(UpdateCategoryEvent(category: result as Category));   
    }
  } 

  Widget _getIcon(){
    return IconListImage(category.iconPath, 35);   
  }
   
  @override
  Widget build(BuildContext context) {
    
    id = category.id;
    return 
      Column(children: <Widget>[     
        ListTile(
          leading: _getIcon(),
          title: Text(category.categoryName),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _navigateAndDisplayCategory(context, id),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteCategory(context,id),
                ),
              ],
            ),
          ),
        ),
       const Divider(height: 2, thickness: 2,)
      ],
    );
  }
}