import 'package:flutter/material.dart';
import '../../bloc/categories/categories_bloc_exports.dart';
import '../../config/injection_container.dart';
import '../../pages/category_screen.dart';
import '../../../domain/entities/category.dart';
import '../../widgets/categories/category_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  CategoryList(this.categories);

  void _navigateAndDisplayCategory(BuildContext context) async {

    var result = await Navigator.of(context).push(MaterialPageRoute(builder: (_) => 
      BlocProvider.value(
        value: sl<CategoriesBloc>(),
        child: CategoryScreen(category: Category(id: 0, categoryName: '', description: '', iconPath: '', usedForCashFlow: true),),
      ),
    ));
    if(result != null){
      CategoriesBloc cb = BlocProvider.of<CategoriesBloc>(context);
      cb.add(InsertCategoryEvent(category: result as Category));   
    }
  } 

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          iconTheme: IconThemeData(color: Colors.black26),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _navigateAndDisplayCategory(context);
              },
            ),
          ],
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 265,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              'Categories',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            background: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/category.jpg'),
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((_, index){
            return CategoryListTile(categories[index]);
          },
          childCount: categories.length,
          ),
        ),
      ],
    );    
  }
}
